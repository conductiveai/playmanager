// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/PlayManager.sol";


contract TestPlayManager is Test {

    address owner = address(this);

    PlayManager playManager;

    struct AccountEvent {
    address user;
    uint256 accountType;
    }

    struct SessionEvent {
        address user;
        uint256 sessionType;
    }

    struct LoginEvent {
        address user;
        uint256 sessionType;
        string sessionId;
        string userId;
    }

    // Play Manager Events
    event AccountCreated(AccountEvent accountEvent);
    event SessionStarted(SessionEvent sessionEvent);
    event DailyLogin(LoginEvent loginEvent);

  function setUp() public {
        playManager = new PlayManager();
    }

    function testInitialize() public {
        string memory appName = "MyApp";
        string memory appId = "123456";


        playManager.initialize(appName, appId);

        assertEq(playManager.getAppName(), appName, "AppName should be set");
        assertEq(playManager.getAppID(), appId, "AppID should be set");
    }

    function testCreateAccount() public {
        
        uint256 accountType = 1;
        
        // Indicate we expect an event w/ params set by end of function
        vm.expectEmit(true, false, false, false);

        // Emit the event we expect to see
        emit AccountCreated(AccountEvent( address(this), accountType));

        // Call createAccount function and assert event emitted

        playManager.createAccount(accountType);
    }

    function testStartSession() public {
        uint256 sessionType = 1;

        // Indicate we expect an event w/ params set by end of function
        vm.expectEmit(true, false, false, false);

        // Emit the event we expect to see
        emit SessionStarted(SessionEvent( address(this), sessionType));

        // Call startSession function and assert event emitted
        playManager.startSession(sessionType);
    }

    function testDailyLogin() public {
        uint256 sessionType = 1;
        string memory sessionId = "123";
        string memory userId = "456";

        // Indicate we expect an event w/ params set by end of function
        vm.expectEmit(true, true, true, true);

        // Emit the event we expect to see
        emit DailyLogin(LoginEvent( address(this), sessionType, sessionId, userId));

        // Call dailyLogin function and assert event emitted
        playManager.dailyLogin(sessionType, sessionId, userId);
    }

    function testPauseAndUnpause() public {

        // Display the contract owner in the logs
        console.log("### Owner: %s", playManager.getOwner());
        
        //lets pretend to be the owner
        vm.prank(address(playManager.getOwner()));

        // Call pause function and assert contract is paused
        playManager.pause();
        assertTrue(playManager.paused(), "Contract should be paused");

        //lets pretend to be the owner
        vm.prank(address(playManager.getOwner()));

        // Call unpause function and assert contract is not paused
        playManager.unpause();
        assertFalse(playManager.paused(), "Contract should not be paused");
    }

}