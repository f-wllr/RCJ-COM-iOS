//
//  ContentView.swift
//  RCJ COM iOS
//
//  Created by Fabian Weller on 05.06.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        /*NavigationStack {
            NavigationLink(destination: RobotListView()) {
                Text("Robots")
                Image(systemName: "robotic.vacuum")
            }
            NavigationLink(destination: SettingsView()) {
                Text("Settings")
                Image(systemName: "gear")
            }
        }*/
    RobotListView()

    }
}

@main
struct RobotApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

#Preview {
    ContentView()
}
