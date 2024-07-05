// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Students is ERC20{

    struct student{
        uint studentid;
        address studentAddress;
        uint marks;
        uint tokenCount;
    }

    uint private studentCount;
    mapping(address => uint) studentIndex;
    address private owner;

    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }


    student[] public studentInfo;

    constructor() ERC20("STUDY COIN","STN"){

        owner = msg.sender;

        _mint(msg.sender,100000);

    }

    function mintTokens(uint _amount)external onlyOwner{
        _mint(msg.sender,_amount);
    }


    function registerStudent(address _address, uint marks) external onlyOwner{
        require(marks <=100);
        student memory newst = student(studentCount,_address,marks,balanceOf(_address));
        studentInfo.push(newst);
        studentIndex[_address] = studentCount;
        studentCount++;
    }

    function rewardStudent(address _address,uint _amount) external onlyOwner{
         _transfer(msg.sender, _address,_amount );
         studentInfo[studentIndex[_address]].tokenCount = balanceOf(_address);
    }

    function displayStudents() external view returns(student[] memory){
        return studentInfo;
    }

    function transferToken(address _to, uint amount) external{
        require(balanceOf(msg.sender)>0);
        _transfer(msg.sender, _to, amount);
    }


    function burnTokens(uint _amount)external{
        _burn(msg.sender, _amount);
    }



}