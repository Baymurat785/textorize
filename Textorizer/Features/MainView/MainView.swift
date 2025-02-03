//
//  ContentView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 29/01/25.
//

import SwiftUI

struct MainView: View {
    @State private var showScanner = false
    @State private var showCamera = false
    @EnvironmentObject var vm: MainViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Button {
                    showScanner = true
                } label: {
                    Image(systemName: "scanner")
                        .foregroundStyle(.white)
                        .padding()
                        .background(
                            Rectangle()
                                .fill(.blue)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
                Button {
                    showCamera = true
                } label: {
                    Image(systemName: "camera")
                        .foregroundStyle(.white)
                        .padding()
                        .background(
                            Rectangle()
                                .fill(.blue)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }

            }
        }
        .padding()
        .fullScreenCover(isPresented: $showScanner) {
            switch vm.accessStatus {
            case .notDetermined:
                Text("Requesting Camera Access")
            case .accessNotGranted:
                Text("Please provide access to the camera in settings")
            case .cameraNotAvailable:
                Text("Your device doesn't have a camera")
            case .scannerAvailable:
                ScannerView()
                    .environmentObject(vm)
            case .scannerNotAvailable:
                Text("Your device doesn't have support for scanning")
            }
        }
        
        .fullScreenCover(isPresented: $showCamera) {
            CameraView()
                .environmentObject(vm)
        }
    }
}
