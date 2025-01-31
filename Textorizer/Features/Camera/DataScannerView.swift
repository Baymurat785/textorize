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
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let vc = DataScannerViewController(
            recognizedDataTypes: [.text()],
            qualityLevel: .fast,
            recognizesMultipleItems: true,
            isGuidanceEnabled: true,
            isHighlightingEnabled: true
        )
        vc.delegate = context.coordinator
        
        do {
            try vc.startScanning()
        } catch {
            print("Failed to start scanning: \(error)")
        }
        
        return vc
    }

    
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedItems: $recognizedItems)
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        guard uiViewController.delegate == nil else { return }

           uiViewController.delegate = context.coordinator
           do {
               try uiViewController.startScanning()
               print("start scanning")
           } catch {
               print("Could not start scanning: \(error)")
           }
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

#Preview {
    DataScannerView(recognizedItems: .constant([]))
}
