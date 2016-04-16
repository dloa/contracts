/*
    File: DaoTest.sol

    Author: Andreas Olofsson (androlo1980@gmail.com)
*/
import "./Test.sol";
import "../errors/Errors.sol";

/*
    Contract: DaoTest

    Contract that binds all valid types to the <Assertions> methods. It also extends <Errors>.
*/
contract DaoTest is Test, Errors {}