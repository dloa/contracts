// SoloPay (tip/contribute to single ether addresses)
// Author:  Bill Gleim
// twitter: @billgleim

contract SoloPay {
    
    address public payer;
    address public payee;

    uint value;

    uint public payerBeginningBalance;
    uint public payeeBeginningBalance;

    uint public payerFinalBalance;
    uint public payeeFinalBalance;

    function SoloPay(address _payeeAddress) {
      payer = msg.sender;
      payee = _payeeAddress;
      value = msg.value;

      payerBeginningBalance = payer.balance;
      payeeBeginningBalance = payee.balance;

      payee.send(value);

      payerFinalBalance = payer.balance;
      payeeFinalBalance = payee.balance;
    }
}
