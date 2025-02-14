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
    @Published var textContentType: TextContentTypeOption = .all
    @Published var copiedToClipBoard: Bool = false
    
    //MARK: - Capture photo
    //    @Published var shouldCapturePhoto = false
    //    @Published var capturedPhoto: IdentifiableImage? = nil
    
    //MARK: - Improved with ChatGPT
    let textContentTypes: [(title: String, textContentType: DataScannerViewController.TextContentType?)] = TextContentTypeOption.allCases.map {
        ($0.rawValue, $0.scannerType)
    }
    

    var recognizedDataType: DataScannerViewController.RecognizedDataType {
        .text(textContentType: textContentType.scannerType)
    }
    //MARK: -
    
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
