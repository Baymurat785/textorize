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
    @State var copiedToClipBoard: Bool = false
    
    var body: some View {
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
            ZStack {
                VStack {
                    headerView
                    //                .disabled(vm.capturedPhoto != nil)
                        .padding(.top)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        CustomSelectableTextView(text: vm.extractedText, selectedText: $vm.selectedText)
                            .frame(minWidth: 40)
                    }
                   /* .frame(height: 400)*/  // FIXME: remove this static height!!
                    
                    if vm.hasStartedScanning {
                        HStack {
                            Button {
                                
                            } label: {
                                Text("Save")
                                    .foregroundStyle(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            }

                            Spacer()
                            
                            Button {
                                //think of adding haptic feedback!!
                                UIPasteboard.general.string = vm.preferredText
                                
                                withAnimation(.linear) {
                                    copiedToClipBoard = true
                                    
                                }
                                DispatchQueue.main.asyncAfter (deadline: .now() + 1.5) {
                                    withAnimation(.linear) {
                                        copiedToClipBoard = false
                                    }
                                }
                            } label: {
                                Text("Copy")
                                    .foregroundStyle(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .overlay(content: {
            if copiedToClipBoard {
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
    
    private var headerView: some View {
        VStack {
            HStack {
                Picker("Text content type", selection: $vm.textContentType) {
                    ForEach(vm.textContentTypes, id: \.self.textContentType) {
                        Text($0.title).tag($0.textContentType)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            HStack {
                Text(vm.headerText)
                    .padding(.top)
//                
//                Button {
//                    vm.shouldCapturePhoto = true
//                } label: {
//                    Image(systemName: "camera.circle")
//                        .imageScale(.large)
//                        .font(.system(size: 32))
//                }
                
                if vm.hasStartedScanning {
                    Button {
                        vm.shouldScan.toggle()
                    } label: {
                        Image(systemName: vm.shouldScan ? "stop.circle" : "text.viewfinder")
                            .imageScale(.large)
                            .font(.system(size: 32))
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    CameraView()
}
