//
//  ContentView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 29/01/25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var vm: MainViewModel
    
    var body: some View {
        VStack {
            CustomSelectableTextView(text: "My name is Baymurat, I slept a lot today. Now sitting in the lecture", selectedText: $vm.selectedText)
                .frame(height: 200)
                .padding()
                .onChange(of: vm.selectedText) { oldValue, newValue in
                    print(newValue)
                }
            
            Spacer()
            
            HStack {
                CustomButton(systemImageName: "scanner") {
                    vm.activeView = .camera
                }
                
                CustomButton(systemImageName: "camera") {
                    vm.activeView = .scanner
                }
                if !vm.selectedText.isEmpty {
                    CustomButton(systemImageName: "star") {
                        print(vm.selectedText)
                    }
                }
            }
        }
        .padding()
        .fullScreenCover(item: $vm.activeView) { view in
            switch view {
            case .camera:
                camera
            case .scanner:
                CameraView()
                    .environmentObject(vm)
            }
        }
    }
    
    private var camera: some View {
        // Fix this request accesss!!
        VStack {
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
    }
}
