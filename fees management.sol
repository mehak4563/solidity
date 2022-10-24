//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.15;
contract feespaid
{
    struct student
    {
        address studentId;
        string name;
        string course;
        bool fees;
    }
    mapping (address=>student) students;
    function payfee() external  payable 
    {
        students[msg.sender].fees= true;
    }
    
    function allowtosit() view external returns(string memory)
    {
        if(students[msg.sender].fees==true)
        {
            return ("you are allowed to sit");
        }
        else 
        {
            return ("not allow to sit");
        }
    }

}
