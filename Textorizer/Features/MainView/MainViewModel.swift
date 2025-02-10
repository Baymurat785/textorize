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

@MainActor
final class MainViewModel: ObservableObject {
    //MARK: - Camera Access
    @Published var accessStatus: CameraAccessStatus = .notDetermined
    
    //MARK: - Scanning & Text recognition
    @Published var recognizedItems: [RecognizedItem] = []
    @Published var extractedItems: [RecognizedItem] = []
    @Published var shouldScan = true
    @Published var selectedText = ""

    //MARK: - UI State
    @Published var activeView: ViewType = .scanner
    @Published var showCamera: Bool = false
    @Published var textContentType: DataScannerViewController.TextContentType?
    
    //MARK: - Capture photo
    //    @Published var shouldCapturePhoto = false
    //    @Published var capturedPhoto: IdentifiableImage? = nil
    
    //Consider improving this!
    let textContentTypes: [(title: String, textContentType: DataScannerViewController.TextContentType?)] = [
        ("All", .none),
        ("URL", .URL),
        ("Phone", .telephoneNumber),
        ("Email", .emailAddress),
        ("Address", .fullStreetAddress)
    ]

    var recognizedDataType: DataScannerViewController.RecognizedDataType {
        .text(textContentType: textContentType)
    }
    
    var hasStartedScanning: Bool {
        !extractedItems.isEmpty
    }
    
    var preferredText: String {
        if selectedText.isEmpty {
            return extractedText
        } else {
            return selectedText
        }
    }
    
    var extractedText: String {
        extractedItems.compactMap { item -> String? in
            if case .text(let text) = item {
                return text.transcript
            }
            return nil
        }
        .joined(separator: "\n")
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
        default: break
        }
    }
}
