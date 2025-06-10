//
//  QRScannerView.swift
//  RCJ COM iOS
//
//  Created by Fabian Weller on 10.06.2025.
//


import SwiftUI
import AVFoundation

struct QRScannerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = QRScannerViewController

    var onScanned: (String) -> Void

    func makeUIViewController(context: Context) -> QRScannerViewController {
        let controller = QRScannerViewController()
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: QRScannerViewController, context: Context) {
        // No updates needed for static QR scanner
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(onScanned: onScanned)
    }

    class Coordinator: NSObject, QRScannerDelegate {
        var onScanned: (String) -> Void

        init(onScanned: @escaping (String) -> Void) {
            self.onScanned = onScanned
        }

        func didScanQRCode(_ code: String) {
            onScanned(code)
        }
    }
}
