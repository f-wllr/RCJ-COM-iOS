//
//  ConnectRobotView.swift
//  RCJ COM iOS
//
//  Created by Fabian Weller on 06.06.2025.
//

import SwiftUI
import AVFoundation

struct ConnectRobotView: View {
    @StateObject private var bleManager = BLEManager.shared
    @State private var manualMac: String = ""
    @State private var selectedMac: String? = nil
    @State private var showScanner = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Connect Robot")
                .font(.largeTitle)

            // BLE Devices List
            List(bleManager.discoveredPeripherals, id: \.identifier) { peripheral in
                Button(action: {
                    selectedMac = peripheral.identifier.uuidString
                }) {
                    HStack {
                        Text(peripheral.name ?? "Unnamed Device")
                        Spacer()
                        Text(peripheral.identifier.uuidString)
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
            }
            .frame(height: 200)

            // Manual Entry
            VStack(alignment: .leading) {
                Text("Manual MAC Address")
                    .font(.headline)
                TextField("Enter MAC", text: $manualMac)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
            }

            // QR Scan Button
            Button(action: {
                showScanner.toggle()
            }) {
                Label("Scan QR Code", systemImage: "qrcode.viewfinder")
            }

            // Connect Button
            Button("Connect") {
                let macToConnect = manualMac.isEmpty ? selectedMac : manualMac
                if let mac = macToConnect {
                    bleManager.connectTo(macAddress: mac)
                }
            }
            .disabled((manualMac.isEmpty && selectedMac == nil))
            .padding()
            .background(Color.blue)
            .foregroundStyle(.white)
            .cornerRadius(8)

            Spacer()
        }
        .padding()
        .onAppear {
            bleManager.startScanning()
        }
        .sheet(isPresented: $showScanner) {
            QRScannerView { scannedString in
                manualMac = scannedString
                showScanner = false
            }
        }

    }
}


#Preview {
    ConnectRobotView()
}
