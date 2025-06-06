//
//  BLEMessage.swift
//  RCJ COM iOS
//
//  Created by Fabian Weller on 05.06.2025.
//


enum BLEMessage: String {
    case ping = "BLE_MSG_PING"
    case fwVersion = "BLE_MSG_FW_VERSION"
    case setName = "BLE_MSG_SET_NAME"
    case setScore = "BLE_MSG_SET_SCORE"
    case play = "BLE_MSG_PLAY"
    case stop = "BLE_MSG_STOP"
    case damage = "BLE_MSG_DAMAGE"
    case halfBreak = "BLE_MSG_HALF_BREAK"
    case gameOver = "BLE_MSG_GAME_OVER"
    case disconnect = "BLE_MSG_DISCONNECT"
}