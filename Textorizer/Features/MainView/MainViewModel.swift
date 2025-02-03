//
//  MainViewModel.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 31/01/25.
//

import Foundation
import SwiftUI
import VisionKit
import AVKit

enum CameraAccessStatus {
    case notDetermined
    case accessNotGranted
    case cameraNotAvailable
    case scannerAvailable
    case scannerNotAvailable
}

@MainActor
final class MainViewModel: ObservableObject {
     @Published var accessStatus: CameraAccessStatus = .notDetermined
    @Published var recognizedItems: [RecognizedItem] = []
    @Published var textContentType: DataScannerViewController.TextContentType?
    
    var recognizedDataType: DataScannerViewController.RecognizedDataType {
        .text(textContentType: textContentType)
    }
    
    var headerText: String {
        if recognizedItems.isEmpty {
            return "Scanning text..."
        } else {
            return "Recognized \(recognizedItems.count) items"
        }
    }
    
    private var isScannerAvailable: Bool {
        DataScannerViewController.isAvailable && DataScannerViewController.isSupported
    }
    
    func requestAccess() async {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            accessStatus = .cameraNotAvailable
            return
        }
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            let granted = await AVCaptureDevice.requestAccess(for: .video)
            if granted {
                accessStatus = isScannerAvailable ? .scannerAvailable : .scannerNotAvailable
            } else {
                accessStatus = .accessNotGranted
            }
        case .restricted, .denied:
            accessStatus = .accessNotGranted
          case .authorized:
            accessStatus = isScannerAvailable ? .scannerAvailable : .scannerNotAvailable
        @unknown default: break
        }
    }
    
}
