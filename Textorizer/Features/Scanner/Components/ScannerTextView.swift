//
//  ScannerTextView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 11/02/25.
//

import SwiftUI
import SwiftData

struct ScannerTextView: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var vm: MainViewModel
    @Environment(\.dismiss) var dismiss
    
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
                            switch vm.textContentType {
                            case .all:
                                let all = AllContent(title: "New ALL", text: vm.extractedText)
                                modelContext.insert(all)
                            case .url:
                                let url = URLContent(title: "New URL", text: vm.extractedText)
                                modelContext.insert(url)
                            case .phone:
                                let phone = PhoneContent(title: "New Phone", text: vm.extractedText)
                                modelContext.insert(phone)
                            case .email:
                                let email = EmailContent(title: "New Email", text: vm.extractedText)
                                modelContext.insert(email)
                            case .address:
                                let address = AddressContent(title: "New Address", address: vm.extractedText)
                                modelContext.insert(address)
                            }
                            
                            do {
                                try modelContext.save()
                                
                            } catch {
                                print("Error saving: \(error.localizedDescription)")
                            }
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
                            #warning("hink of adding haptic feedback!!")
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
                    ForEach(TextContentTypeOption.allCases, id: \.id) {type in
                        Text(type.title).tag(type)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
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
