//Write your own contracts here. Currently compiles using solc v0.4.15+commit.bbb8e64f.
pragma solidity 0.4.24;


contract IncentiveManager {

  address owner;
  mapping(string => Incentive)  incentives;
  mapping(address => bool) doctors;

  constructor() public {
    owner = msg.sender;
  }

  // EX. incentiveName => personalVaccine, incentiveType => personal, reward => 6
  struct Incentive {   
    address [] completedUsers;
    string incentiveName;
    string incentiveType;
    uint256 reward;
  }  
  
  function createIncentive(string incentiveName, string incentiveType, uint256 reward) public {
    require(owner == msg.sender);
    Incentive memory incentive = Incentive(new address[](0), incentiveName, incentiveType, reward);   
    incentives[incentiveName] = incentive;
  }

  function addCompletionToIncentive(string incentiveName, address completedUser) public {
    require(owner == msg.sender || doctors[msg.sender] == true );
    incentives[incentiveName].completedUsers.push(completedUser);
  }

  function getIncentiveCompletions(string incentiveName) public view returns (address []) {
    return incentives[incentiveName].completedUsers;
  }

  function addDoctor (address doctorAddress) public {
    require(owner == msg.sender);
    doctors[doctorAddress] = true;
  }
   
}