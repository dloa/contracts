// SplitPay (tip/contribute to multiple ether addresses)
// Author:  Bill Gleim
// twitter: @billgleim

contract SplitPay {
    
    // creates an enumerated type called Actor which consists of Creator and Promoter
    enum Actor { Creator, Promoter }

    // builds a variable (struct) called Payee which has two sub-variables, an address called payoutAddress and a uint called percentage     
    struct Payee
    {
        address payoutAddress;
        uint    percentage;
        Actor   payeeType;
    }
    
    struct SplitPayData {
        // number of payout recipients
        uint num_payees;

        // contract indexing for split-pay support: multiple payees
        mapping(address => Payee) private payees;

        // currently only supporting single-buyer support:
        //   if there exist multiple contributors/tippers, each will 
        //   require their own interface to the split-pay contract
        address buyer;
    }

    // events are returned after functions are successfully called
    event onPayout(address indexed from, uint indexed lid, uint _value);

 function addBuyer(address _buyerAddress)
    {
        // set the internal buyer 
        buyer = _buyerAddress;
    }

 function addPayee(address _payeeAddress, uint _payeePercentage, Actor _payeeType)
    {
        // add to the internal set of payees
        payees[_payeeAddress] = Payee(_payeeAddress, _payeePercentage, _payeeType);
    }

 function payout(int _payoutAmount)
    {
        // validate payee amount summation
        int validatedPayoutAmount = 0;
    }
state:
    SplitPayData splitPayData;
 }
