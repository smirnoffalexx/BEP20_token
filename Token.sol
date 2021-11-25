pragma solidity ^0.8.2;

contract Token {
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowance;
    uint256 public totalSupply = 10000 * 10**18;
    string public name = "My Token";
    string public symbol = "TKN";
    uint256 public decimals = 18;

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(address indexed owner, address indexed spender, uint256 amount);

    constructor() {
        balances[msg.sender] = totalSupply;
    }

    function balanceOf(address owner) public view returns(uint256) {
        return balances[owner];
    }

   function transfer(address to, uint256 amount) public returns(bool) {
       require(balanceOf(msg.sender) >= amount, "Balance is less than amount");
       balances[to] += amount;
       balances[msg.sender] -= amount;
       emit Transfer(msg.sender, to, amount);
       return true;
   }

    function approve(address spender, uint256 amount) public returns(bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public returns(bool) {
        require(balanceOf(from) >= amount, "Sender balance is less than amount");
        require(allowance[from][msg.sender] >= amount, "It is not approved to send enougth from tokens by msg.sender");
        balances[to] += amount;
        balances[from] -= amount;
        emit Transfer(from, to, amount);
        return true;
    }

}
