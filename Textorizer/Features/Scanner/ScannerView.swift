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
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    //ID was causing app crash
                    liveImageFeed
                        .environmentObject(vm)
                        .edgesIgnoringSafeArea(.all)
                        .id(vm.textContentType) // potentially, this is causing app to become freeze!!
                    
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
                .sheet(isPresented: .constant(true)) {
                    ScannerTextView()
                        .background(Color.gray.opacity(0.3))
                        .environmentObject(vm)
                        .presentationDetents([.height(geometry.size.height * 0.2), .medium])
                        .interactiveDismissDisabled()
                }
            }
            .overlay(content: {
                if vm.copiedToClipBoard {
                    Text("Copied to Clipboard")
                        .font(.system(.body, design: .rounded, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.blue.clipShape(RoundedRectangle(cornerRadius: 20)))
                        .padding(.bottom)
                        .shadow(radius: 5)
                        .transition(.move(edge: .top))
                        .frame(maxHeight: .infinity, alignment: .top)
                }
            })
            
            //        .sheet(item: $vm.capturedPhoto, content: { photo in
    //            VStack() {
    //                LiveTextView(image: photo.image)
    //                Button {
    //                    vm.capturedPhoto = nil
    //                } label: {
    //                    Image(systemName: "xmark.circle.fill")
    //                }
    //                .foregroundStyle(.white)
    //                .padding([.trailing, .top])
    //            }
    //        })
            .task {
                await vm.requestAccess()
            }
            .onChange(of: vm.recognizedItems) {
                if !vm.recognizedItems.isEmpty {
                    vm.extractedItems = vm.recognizedItems
                }
            }

        }
    }
    
    @ViewBuilder
    private var liveImageFeed: some View {
//        if let capturedPhoto = vm.capturedPhoto {
//            Image(uiImage: capturedPhoto.image)
//                .resizable()
//                .scaledToFit()
//            
//        } else {
            DataScannerView(
                recognizedItems: $vm.recognizedItems,
//                shouldCapturePhoto: $vm.shouldCapturePhoto,
//                capturedPhoto: $vm.capturedPhoto,
                shouldScan: $vm.shouldScan,
                recognizedDataType: vm.recognizedDataType
            )
//        }
    }
}

#Preview {
    CameraView()
}
