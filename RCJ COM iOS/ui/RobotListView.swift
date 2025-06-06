//
//  RobotListView.swift
//  RCJ COM iOS
//
//  Created by Fabian Weller on 05.06.2025.
//


import SwiftUI

struct RobotListView: View {
    @AppStorage("selectedGameMode") private var selectedGameMode: String = "2 v 2"
    @State private var robots: [Robot] = []
    @StateObject private var timer = GameTimer()

    let stringToIntMap: [String: Int] = [
        "1 v 1": 2,
        "2 v 2": 4,
        "Superteam": 10
    ]

    var body: some View {
        NavigationStack {
            VStack {
            
                /*--- Navigation ---*/
                HStack {
                    Spacer()
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                    }
                }
                
                Spacer()
                
                /*--- Main Components---*/
                Text("Robots").font(.largeTitle)

                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2)) {
                    ForEach(robots.indices, id: \.self) { i in
                        VStack {
                            Text("Robot \(robots[i].number)")
                            if robots[i].isDamaged {
                                Text("Damaged")
                            }
                            Button("Damage") {
                                damageRobot(index: i)
                            }
                            .disabled(robots[i].isDamaged)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                }

                Spacer()
                
                HStack {
                    Button("Start Game") {
                        BLEManager.shared.send(.play)
                        timer.start()
                    }
                    .padding()
                    .background(Color.green.opacity(0.8))
                    .foregroundStyle(Color.white)
                    .cornerRadius(10)

                    Button("Stop Game") {
                        BLEManager.shared.send(.stop)
                        timer.timer?.invalidate()
                    }
                    .padding()
                    .background(Color.red.opacity(0.8))
                    .foregroundStyle(Color.white)
                    .cornerRadius(10)
                }

                Text("Time Remaining: \(timer.timeRemaining / 60):\(String(format: "%02d", timer.timeRemaining % 60))min")
                Spacer()
            }
            .padding()
            .onAppear {
                updateRobots(for: selectedGameMode)
            }
            .onChange(of: selectedGameMode) { newMode in
                updateRobots(for: newMode)
            }
            .background(Color.darkBack)
        }
    }

    private func updateRobots(for mode: String) {
        let count = stringToIntMap[mode] ?? 0
        robots = (1...count).map { Robot(number: $0) }
    }

    func damageRobot(index: Int) {
        robots[index].isDamaged = true
        BLEManager.shared.send(.damage)
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            robots[index].isDamaged = false
        }
    }
}

#Preview {
    RobotListView()
}
