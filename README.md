# ERC20
This Solidity smart contract defines an ERC-20 token called "STUDY COIN" (symbol: STN) using the OpenZeppelin library. The contract is designed to manage student information and their associated tokens.
## Description
For this project, you will write a smart contract to create your own ERC20 token and deploy it using HardHat or Remix. Once deployed, you should be able to interact with it for your walk-through video. From your chosen tool, the contract owner should be able to mint tokens to a provided address and any user should be able to burn and transfer tokens.
## Getting started
This code we are running on the online Solidity IDE that is https://remix.ethereum.org/ here we'll perform the code. as we are on the remix website just by clicking on the start coding we'll able to do coding in Solidity.
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
To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.18" (or another compatible version), and then click on the ("Compile "the name of the file" ") for ex. comple first.sol button. Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "newmy.sol" contract from the dropdown menu, and then click on the "Deploy" button. then u can see a the below of the option ' Deployed/Unpinned Contracts ' expand it and balances mint burn etc and now u can see our code is ready to run .
## Program explaination
import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; This import statement brings in the ERC20 implementation from the OpenZeppelin library, providing standard ERC20 token functionality.

function mintTokens(uint _amount) external onlyOwner {
    _mint(msg.sender, _amount);
}
Allows the owner to mint new tokens.

function registerStudent(address _address, uint marks) external onlyOwner{
        require(marks <=100);
        student memory newst = student(studentCount,_address,marks,balanceOf(_address));
        studentInfo.push(newst);
        studentIndex[_address] = studentCount;
        studentCount++;
    }
registerStudent: Allows the owner to register a new student. It requires the student's address and marks (which must be less than or equal to 100). It creates a new student struct, stores it in the studentInfo array, and updates the studentIndex mapping.

function rewardStudent(address _address,uint _amount) external onlyOwner{
         _transfer(msg.sender, _address,_amount );
         studentInfo[studentIndex[_address]].tokenCount = balanceOf(_address);
    }
rewardStudent: Allows the owner to transfer tokens from the owner's balance to a student's address. After the transfer, it updates the student's tokenCount to reflect the new balance.

function displayStudents() external view returns(student[] memory){
        return studentInfo;
    }
displayStudents: Returns the list of all registered students.

function transferToken(address _to, uint amount) external{
       require(balanceOf(msg.sender)>0);
       _transfer(msg.sender, _to, amount);
   }
transferToken: Allows any user to transfer tokens to another address. The sender must have a positive balance.

function burnTokens(uint _amount)external{
        _burn(msg.sender, _amount);
    }
burnTokens: Allows any user to burn (destroy) a specified amount of their tokens, reducing the total supply.
# AUTHORS
Vineet Kaur
kaurvineet80@gmail.com
#License
This project is licensed under the MIT License - see the LICENSE.md file for details
