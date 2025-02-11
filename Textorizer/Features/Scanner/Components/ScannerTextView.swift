//
//  ScannerTextView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 11/02/25.
//

import SwiftUI

struct ScannerTextView: View {
    @EnvironmentObject var vm: MainViewModel
    
    var body: some View {
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
                            
                            withAnimation {
                                vm.copiedToClipBoard = true
                                
                            }
                            DispatchQueue.main.asyncAfter (deadline: .now() + 1.5) {
                                withAnimation {
                                    vm.copiedToClipBoard = false
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
