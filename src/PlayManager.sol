// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 _______  __                   __       __                                                       
|       \|  \                 |  \     /  \                                                      
| ▓▓▓▓▓▓▓\ ▓▓ ______  __    __| ▓▓\   /  ▓▓ ______  _______   ______   ______   ______   ______  
| ▓▓__/ ▓▓ ▓▓|      \|  \  |  \ ▓▓▓\ /  ▓▓▓|      \|       \ |      \ /      \ /      \ /      \ 
| ▓▓    ▓▓ ▓▓ \▓▓▓▓▓▓\ ▓▓  | ▓▓ ▓▓▓▓\  ▓▓▓▓ \▓▓▓▓▓▓\ ▓▓▓▓▓▓▓\ \▓▓▓▓▓▓\  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\
| ▓▓▓▓▓▓▓| ▓▓/      ▓▓ ▓▓  | ▓▓ ▓▓\▓▓ ▓▓ ▓▓/      ▓▓ ▓▓  | ▓▓/      ▓▓ ▓▓  | ▓▓ ▓▓    ▓▓ ▓▓   \▓▓
| ▓▓     | ▓▓  ▓▓▓▓▓▓▓ ▓▓__/ ▓▓ ▓▓ \▓▓▓| ▓▓  ▓▓▓▓▓▓▓ ▓▓  | ▓▓  ▓▓▓▓▓▓▓ ▓▓__| ▓▓ ▓▓▓▓▓▓▓▓ ▓▓      
| ▓▓     | ▓▓\▓▓    ▓▓\▓▓    ▓▓ ▓▓  \▓ | ▓▓\▓▓    ▓▓ ▓▓  | ▓▓\▓▓    ▓▓\▓▓    ▓▓\▓▓     \ ▓▓      
 \▓▓      \▓▓ \▓▓▓▓▓▓▓_\▓▓▓▓▓▓▓\▓▓      \▓▓ \▓▓▓▓▓▓▓\▓▓   \▓▓ \▓▓▓▓▓▓▓_\▓▓▓▓▓▓▓ \▓▓▓▓▓▓▓\▓▓      
                     |  \__| ▓▓                                      |  \__| ▓▓                  
                      \▓▓    ▓▓                                       \▓▓    ▓▓                  
                       \▓▓▓▓▓▓                                         \▓▓▓▓▓▓                   
----------------------------------
Play Manager Smart Contract v1.0.0
----------------------------------
Author:         Conductive Eng. team @ https://conductive.ai
Learn more:     https://conductive.ai/instantplay
Documentation:  https://docs.conductive.ai
 */

import "openzeppelin-contracts-upgradeable/proxy/utils/Initializable.sol";
import "openzeppelin-contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "openzeppelin-contracts-upgradeable/access/OwnableUpgradeable.sol";
import "openzeppelin-contracts-upgradeable/security/PausableUpgradeable.sol";

contract PlayManager is Initializable, PausableUpgradeable, UUPSUpgradeable, OwnableUpgradeable {

    // Contract variables
    string private appName;
    string private appID;

    // Const contract version
    string private constant APP_VERSION = "1.0.0";

    // Event struct definitions
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
    // Proxy contract initializer
    function initialize(string memory _appName, string memory _appID) initializer public {

        __Ownable_init();
        __Pausable_init();
        __UUPSUpgradeable_init();

        appName = _appName;
        appID = _appID;

        //set the deployer as owner
        transferOwnership(_msgSender());

    }

    /** ========== SETTERS ========== **/
    function setAppName(string memory _appName) external onlyOwner {
        appName = _appName;
    }

    function setAppID(string memory _appID) external onlyOwner {
        appID = _appID;
    }

    /** ========== GETTERS ========== **/

    function getAppName() external view returns (string memory) {
        return string(abi.encodePacked(appName));
    }

    function getAppID() external view returns (string memory) {
        return string(abi.encodePacked(appID));
    }

    function getAppVersion() external pure returns (string memory) {
        return string(abi.encodePacked(APP_VERSION));
    }

    function getOwner() external view returns (address) {
        return owner();
    }

    /** ========== MAIN APP FUNCTIONS ========== **/

    function createAccount(uint256 accountType) external whenNotPaused {

        // create AccountEvent
        AccountEvent memory accountEvent = AccountEvent(_msgSender(), accountType);
        emit AccountCreated(accountEvent);
    }

    function startSession(uint256 sessionType) external whenNotPaused {
        SessionEvent memory sessionEvent = SessionEvent(_msgSender(), sessionType);

        emit SessionStarted(sessionEvent);
    }

    function dailyLogin(uint256 sessionType, string calldata sessionId, string calldata userId) external whenNotPaused {

        LoginEvent memory loginEvent = LoginEvent(_msgSender(), sessionType, sessionId, userId);
        emit DailyLogin(loginEvent);
    }

    /** ========== ADMIN FUNCTIONS ========== **/

    // Proxy contract upgrade function
    function _authorizeUpgrade(address) internal override onlyOwner {}

    // Pause and unpause functions
    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    //reserve space in the contract storage for future upgrades, in case any additional storage variables are added to the contract in future upgrades.
    uint256[50] private __gap;
}