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
    //MARK:  Scanning & Text recognition
    @Published var recognizedItems: [RecognizedItem] = []
    @Published var extractedItems: [RecognizedItem] = []
    @Published var shouldScan = true
    @Published var selectedText = ""

    //MARK: - UI State
    @Published var activeView: ViewType = .scanner
    @Published var showCamera: Bool = false
    @Published var textContentType: TextContentTypeOption = .all
    
    //for toast view
    @Published var toastText = ""
    @Published var showToast = false
    
    
    @Published var showExtractedText = false
    @Published var isFooterExpanded = false
    @Published var selectedFileType: FileType = .pdf
    
    //MARK: Improved with ChatGPT
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
}
