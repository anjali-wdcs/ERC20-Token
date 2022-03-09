// SPDX-License-Identifier: MIT
pragma solidity^0.8.0;

contract MyERC20 {

    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowance;

    event Transfer(address indexed from, address indexed to, uint indexed _amount);
    event Allowance(address indexed _owner, address indexed _spender, uint indexed _amount);

    string public name = "NTC NodeCoin";
    string public symbol = "NTC";
    uint public decimals = 18;
    uint public totalSupply = 1000000 *(10**decimals);   

    constructor() {
        balances[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    }
    

    function transfer(address to, uint amount) public returns(bool success) {
        require(balances[msg.sender] > amount, "Not enough amount of tokens");
        balances[msg.sender] -= amount;
        balances[to] += amount;

        emit Transfer(msg.sender, to, amount);
        return true;
    }
    

    function transferFrom(address _from, address _to, uint _amount) public returns(bool success) {
        require(allowance[_from][msg.sender] >= _amount, "Not approved to transfer");
        require(balances[_from] >= _amount, "Not enough tokens to transfer");

        balances[_from] -= _amount;
        balances[_to] += _amount;
        allowance[_from][msg.sender] -= _amount;

        emit Transfer(_from, _to, _amount);
        return true;
    }
    

    function approve(address spender, uint amount) public returns(bool success) {
        allowance[msg.sender][spender] = amount;
        emit Allowance(msg.sender, spender, amount);
        return true;
    }

}
