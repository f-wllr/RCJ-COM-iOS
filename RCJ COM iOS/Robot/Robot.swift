//
//  Robot.swift
//  RCJ COM iOS
//
//  Created by Fabian Weller on 05.06.2025.
//


import Foundation

struct Robot: Identifiable {
    let id: UUID = UUID()
    let number: Int
    var isConnected: Bool = false
    var isDamaged: Bool = false
    var damageEndTime: Date?
    
}
