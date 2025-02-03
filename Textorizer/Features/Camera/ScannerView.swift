//
//  CameraView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 30/01/25.
//

import SwiftUI
import VisionKit


struct ScannerView: View {
    @EnvironmentObject var vm: MainViewModel
    @Environment(\.dismiss) var dismiss
    
    private let textContentTypes: [(title: String, textContentType: DataScannerViewController.TextContentType?)] = [
        ("All", .none),
        ("URL", .URL),
        ("Phone", .telephoneNumber),
        ("Email", .emailAddress),
        ("Address", .fullStreetAddress)
    ]
    
    
    var body: some View {
        ZStack() {
            DataScannerView(recognizedItems: $vm.recognizedItems, recognizedDataType: vm.recognizedDataType)
                .environmentObject(vm)
                .edgesIgnoringSafeArea(.all)
                .task {
                    await vm.requestAccess()
                }
                .id(vm.textContentType)
            
            // Close button in top-left corner:
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.4))
                            .clipShape(Circle())
                            .padding([.top, .leading], 16)
                    }
                    
                    Spacer()
                }
                Spacer()
            }
        }
        
        VStack {
            headerView
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(vm.recognizedItems) { item in
                        switch item {
                        case .text(let text):
                            Text(text.transcript)
                                .padding()
                                .background(Color.secondary.opacity(0.2))
                                .cornerRadius(8)
                                .padding(.horizontal)
                        default:
                            Text("")
                        }
                    }
                }
            }
        }
        .task {
            await vm.requestAccess()
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
                .pickerStyle(.segmented)
            }
            
            Text(vm.headerText)
                .padding(.top)
        }
        .padding(.horizontal)
    }
}

#Preview {
    CameraView()
}
