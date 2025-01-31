//
//  ContentView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 29/01/25.
//

import SwiftUI
import VisionKit

struct MainView: View {
    @State private var showCamera = false
    @EnvironmentObject var vm: MainViewModel
    
    
    private let textContentTypes: [(title: String, textContentType: DataScannerViewController.TextContentType?)] = [
        ("All", .none),
        ("URL", .URL),
        ("Phone", .telephoneNumber),
        ("Email", .emailAddress),
        ("Address", .fullStreetAddress)
    ]
    
    var body: some View {
        VStack {
            Spacer()
            
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
        .padding()
        .fullScreenCover(isPresented: $showCamera) {
            switch vm.accessStatus {
            case .notDetermined:
                Text("Requesting Camera Access")
            case .accessNotGranted:
                Text("Please provide access to the camera in settings")
            case .cameraNotAvailable:
                Text("Your device doesn't have a camera")
            case .scannerAvailable:
                mainView
            case .scannerNotAvailable:
                Text("Your device doesn't have support for scanning")
            }
        }
    }
    
    private var mainView: some View {
        VStack {
            DataScannerView(recognizedItems: $vm.recognizedItems)
                .environmentObject(vm)
                .task {
                    await vm.requestAccess()
                }
            
            VStack {
                headerView
                
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(vm.recognizedItems) { item in
//                            Text(item)
                        }
                    }
                }
            }
        }
    }
    
    private var headerView: some View {
        VStack {
            HStack {
                Picker("Text content type", selection: $vm.textContentType) {
                    ForEach(textContentTypes, id: \.self.textContentType) {
                        Text($0.title).tag($0.textContentType)
                    }
                }
            }
        }
    }
}
