//
//  CameraView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 30/01/25.
//

import SwiftUI
import VisionKit
import PDFKit
import AVKit
import TipKit

struct ScannerView: View {
    @EnvironmentObject var vm: MainViewModel
    @Environment(\.dismiss) var dismiss
    @State private var isCameraDenied = false
    
#warning("Change the naming!!!!")
    @State var compassTips = TipGroup(.ordered) {
        TextContentTypeTip()
        ExpandFooterTip()
        PDFTip()
        ScanTip()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack() {
                    DataScannerView(
                        recognizedItems: $vm.recognizedItems,
                        shouldScan: $vm.shouldScan,
                        recognizedDataType: vm.recognizedDataType
                    )
                    .edgesIgnoringSafeArea(.all)
                    .id(vm.textContentType)
                    
                    VStack {
                        HeaderView(geometry: geometry, dismiss: { dismiss() }, compassTip: $compassTips)
                        
                        Spacer()
                        
                        FooterView(geometry: geometry, compassTips: $compassTips)
                    }
                    
                    if isCameraDenied {
                        Button("Go to Settings") {
                            openAppSettings()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
            
            .overlay(content: {
                if vm.showToast {
                    ToastView(text: vm.toastText)
                }
            })
            .onAppear(perform: {
                checkCameraPermission()
            })
            .onChange(of: vm.recognizedItems) {
                if !vm.recognizedItems.isEmpty {
                    vm.extractedItems = vm.recognizedItems
                }
            }
        }
    }
    
    //Corrected the logic of requesting access with the help of ChatGPT
    func checkCameraPermission() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            print("Camera access granted")
        case .denied, .restricted:
            isCameraDenied = true
        case .notDetermined:
            requestCameraPermission()
        @unknown default:
            break
        }
    }
    
    func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                if !granted {
                    isCameraDenied = true
                }
            }
        }
    }
    
    func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
    
}
