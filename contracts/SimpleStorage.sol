// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

contract SimpleStorage {
    // uint256 public favouriteNumber;
    uint256 favouriteNumber;
    //People public people = People({favouriteNumber: 6,name: "Nikhil"});
    People[] public arr_people;

    mapping(string => uint256) public nameToNumber;

    struct People {
        uint256 favouriteNumber;
        string name;
    }

    function store(uint256 _favouriteNumber) public virtual {
        favouriteNumber = _favouriteNumber;
    }

    // view function doesn't spend gas as it doesn't allow modification in blockchain
    function retrieve() public view returns(uint256) {
        return favouriteNumber;
    }

    // calldata, memory, storage
    // member assigned with calldata can't change the value after initialized
    
    function addPerson(string memory _name, uint256 _favouriteNumber) public {
        People memory newPerson = People(_favouriteNumber, _name);
        arr_people.push(newPerson);

        nameToNumber[_name] = _favouriteNumber;
        //arr_people.push(People({name: _name, favouriteNumber: _favouriteNumber}));
    }


    /*
    // pure functions doesn't allow modification as well as reading from blockchain
    function add() public pure returns(uint256) {
        return 1+1;
    }
    */

    // 0xd9145CCE52D386f254917e481eB44e9943F39138
}