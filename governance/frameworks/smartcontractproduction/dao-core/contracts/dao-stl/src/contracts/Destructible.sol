/*
    File: Destructible.sol

    Author: Andreas Olofsson (androlo1980@gmail.com)

    Contract: Destructible

    Interface for destructible (deletable) contracts.
    Should be implemented by contracts that are used as doug actions or database contracts,
    so that the contract can be automatically destroyed when it is removed from Doug.
*/
contract Destructible {

    /*
        Event: Destroy

        Params:
            fundReceiver (address) - The account that receives the funds.
            value (uint) - The value of the contract account.
            error (uint16) - An error code.
    */
    event Destroy(address indexed fundReceiver, uint indexed value, uint16 indexed error);

    /*
        Function: destroy

        Destroy a contract. No return values since it's a destruction. Calls 'selfdestruct'
        on the contract if successful.

        Params:
            fundReceiver (address) - The account that receives the funds.
    */
    function destroy(address fundReceiver);
}