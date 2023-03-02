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

import "openzeppelin-contracts-upgradeable/access/OwnableUpgradeable.sol";
import "openzeppelin-contracts-upgradeable/security/PausableUpgradeable.sol";
import "openzeppelin-contracts-upgradeable/proxy/utils/Initializable.sol";
import "openzeppelin-contracts-upgradeable/metatx/ERC2771ContextUpgradeable.sol";


contract PlayManager is Initializable, OwnableUpgradeable, PausableUpgradeable, ERC2771ContextUpgradeable{

    // Contract variables
    bytes32 private AppName;
    bytes32 private AppID;
    bytes32 private AppVersion = "1.0.0";

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
    function initialize(address trustedForwarder, string memory _appName, string memory _appID) initializer public {

        __Ownable_init();
        __Pausable_init();
        __ERC2771Context_init(trustedForwarder);

        AppName = _appName;
        AppID = _appID;

    }

    /** ========== SETTERS ========== **/
    function setAppName(bytes32 memory _appName) external onlyOwner {
        AppName = _appName;
    }

    function setAppID(bytes32 memory _appID) external onlyOwner {
        AppID = _appID;
    }

    /** ========== GETTERS ========== **/

    function getAppName() external view returns (string memory) {
        return string(abi.encodePacked(AppName));
    }

    function getAppID() external view returns (string memory) {
        return string(abi.encodePacked(AppID));
    }

    function getAppVersion() external view returns (string memory) {
        return string(abi.encodePacked(AppVersion));
    }

    /** ========== MAIN APP FUNCTIONS ========== **/

    function createAccount(uint256 accountType) external whenNotPaused {

        emit AccountCreated(_msgSender(), accountType);
    }

    function startSession(uint256 sessionType) external whenNotPaused {

        emit SessionStarted(sessionEvent);
    }

    function dailyLogin(uint256 sessionType, string calldata sessionId, string calldata userId) external whenNotPaused {

        emit DailyLogin(loginEvent);
    }

    /** ========== ADMIN FUNCTIONS ========== **/

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    /** ========== PRIVATE INTERNAL FUNCTIONS ========== **/

    function _msgSender() internal view override(ContextUpgradeable, ERC2771ContextUpgradeable) returns (address sender) {
        return ERC2771ContextUpgradeable._msgSender();
    }

    function _msgData() internal view override(ContextUpgradeable, ERC2771ContextUpgradeable) returns (bytes memory) {
        return ERC2771ContextUpgradeable._msgData();
    }

    uint256[50] private __gap;
}