//
//  DataScannerView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 31/01/25.
//

import SwiftUI
import VisionKit

struct DataScannerView: UIViewControllerRepresentable {
    @Binding var recognizedItems: [RecognizedItem]
//    @Binding var shouldCapturePhoto: Bool
//    @Binding var capturedPhoto: IdentifiableImage?
    @Binding var shouldScan: Bool
    
    let recognizedDataType: DataScannerViewController.RecognizedDataType
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        
        let vc = DataScannerViewController(
            recognizedDataTypes: [recognizedDataType],
            qualityLevel: .accurate,
            recognizesMultipleItems: true,
            isGuidanceEnabled: true,
            isHighlightingEnabled: true
        )
        vc.delegate = context.coordinator
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        uiViewController.delegate = context.coordinator
        if shouldScan {
            try? uiViewController.startScanning()
        } else {
            uiViewController.stopScanning()
        }

        
//        if shouldCapturePhoto {
//            DispatchQueue.main.async {
//                self.shouldCapturePhoto = false
//            }
//            capturePhoto(dataScannerVC: uiViewController)
//        }
    }
    
    //For debugging an error from NSError, I used ChatGPT
//    private func capturePhoto(dataScannerVC: DataScannerViewController) {
//        Task { @MainActor in
//            do {
//                let photo = try await dataScannerVC.capturePhoto()
//                self.capturedPhoto = .init(image: photo)
//            } catch {
//                let nsError = error as NSError
//                   print("Error domain: \(nsError.domain)")
//                   print("Error code: \(nsError.code)")
//                   print("Description: \(nsError.localizedDescription)")
//            }
//        }
//    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedItems: $recognizedItems)
    }
    
    static func dismantleUIViewController(_ uiViewController: DataScannerViewController, coordinator: Coordinator) {
        uiViewController.stopScanning()
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        @Binding var recognizedItems: [RecognizedItem]
        
        init(recognizedItems: Binding<[RecognizedItem]>) {
            self._recognizedItems = recognizedItems
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            print("did tap on item \(item)")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            recognizedItems = allItems
            print("didAddItems \(addedItems)")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            recognizedItems = allItems
            print("didRemoveItems \(removedItems)")
        }
        
        
        func dataScanner(_ dataScanner: DataScannerViewController, becameUnavailableWithError error: DataScannerViewController.ScanningUnavailable) {
            print("")
        }
    }
}

struct IdentifiableImage: Identifiable {
    let id = UUID()
    let image: UIImage
    
}
