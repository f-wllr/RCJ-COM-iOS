//
//  Settings.swift
//  RCJ COM iOS
//
//  Created by Fabian Weller on 05.06.2025.
//

import SwiftUI

struct SettingsView: View {
    var gameModes = ["1 v 1", "2 v 2", "Superteam"]
    
    @AppStorage("selectedGameMode") private var selectedGameMode: String = "2 v 2"
    @State private var robots: [Robot] = []

    let stringToIntMap: [String: Int] = [
        "1 v 1": 2,
        "2 v 2": 4,
        "Superteam": 10
    ]

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Text("Game Mode: ").font(.largeTitle)
                    Menu(selectedGameMode) {
                        ForEach(gameModes, id: \.self) { mode in
                            Button(mode) {
                                selectedGameMode = mode
                                updateRobots(for: mode)
                            }
                        }
                    }
                    .font(.largeTitle)
                    
                    Spacer()
                }
                
                Spacer()
                
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2)) {
                    ForEach(robots.indices, id: \.self) { i in
                        VStack {
                            Text("Robot \(robots[i].number)")
                            if robots[i].isConnected {
                                Text("Connected")
                            }
                            NavigationLink(destination: ConnectRobotView()) {
                                Text("Connect")
                            }
                            .disabled(robots[i].isDamaged)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                }
                
                Spacer()
            }
            .onAppear {
                updateRobots(for: selectedGameMode)
            }
            .background(Color.darkBack)
        }
    }
    
    private func updateRobots(for mode: String) {
        let count = stringToIntMap[mode] ?? 0
        robots = (1...count).map { Robot(number: $0) }
    }
}

#Preview {
    SettingsView()
}
