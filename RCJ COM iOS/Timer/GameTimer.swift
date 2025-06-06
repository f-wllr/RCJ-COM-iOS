//
//  GameTimer.swift
//  RCJ COM iOS
//
//  Created by Fabian Weller on 05.06.2025.
//


import Foundation
import Combine

class GameTimer: ObservableObject {
    @Published var timeRemaining: Int = 600
    @Published var phase: Int = 1 // 1 = play, 2 = break, 3 = play
    var timer: Timer?

    func start() {
        timeRemaining = 600
        phase = 1
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.tick()
        }
    }

    func tick() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            switch phase {
            case 1:
                phase = 2
                timeRemaining = 300
                BLEManager.shared.send(.halfBreak)
            case 2:
                phase = 3
                timeRemaining = 600
                BLEManager.shared.send(.play)
            case 3:
                BLEManager.shared.send(.gameOver)
                timer?.invalidate()
            default:
                break
            }
        }
    }
}