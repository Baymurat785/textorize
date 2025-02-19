//
//  TextorizerApp.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 29/01/25.
//

import SwiftUI
import SwiftData

@main
struct TextorizerApp: App {
    @StateObject private var vm = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(vm)
                .fullScreenCover(isPresented: $vm.showCamera) {
                    CameraView()
                        .environmentObject(vm)
                }
                .modelContainer(for: [AllContent.self, EmailContent.self, PhoneContent.self, URLContent.self, AddressContent.self])
        }
    }
    
#warning("Handle the case when the user does not allow the access for the camera for the first time")
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
                CameraView()
                    .environmentObject(vm)
            case .scannerNotAvailable:
                Text("Your device doesn't have support for scanning")
            }
        }
    }
}
