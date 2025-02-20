//
//  CameraView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 30/01/25.
//

import SwiftUI
import VisionKit
import PDFKit

struct ScannerView: View {
    @EnvironmentObject var vm: MainViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack() {
                    //ID was causing app crash
                    //FIXME: Change name
                    DataScannerView(
                        recognizedItems: $vm.recognizedItems,
                        shouldScan: $vm.shouldScan,
                        recognizedDataType: vm.recognizedDataType
                    )
                    .edgesIgnoringSafeArea(.all)
                    .id(vm.textContentType) // potentially, this is causing app to become freeze!!
                    
                    VStack {
                        HeaderView(geometry: geometry, dismiss: { dismiss() })
                        
                        Spacer()
                        
                        FooterView(geometry: geometry)
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
            
            //FIXME: Fix this!
            .overlay(content: {
                if vm.showToast {
                    ToastView(text: vm.toastText)
                }
            })
            .task {
                await vm.requestAccess()
            }
            .onChange(of: vm.recognizedItems) {
                if !vm.recognizedItems.isEmpty {
                    DispatchQueue.main.async {
                        vm.extractedItems = vm.recognizedItems
                    }
                }
            }
        }
    }
}

#Preview {
    CameraView()
}
