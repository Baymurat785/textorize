//
//  FooterView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 15/02/25.
//

import SwiftUI
import TipKit

struct FooterView: View {
    let geometry: GeometryProxy
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Environment(\.displayScale) var displayScale
    @EnvironmentObject var vm: MainViewModel
    @State var rotationAngle: Double = 0
    @State private var showAlert = false
    @State private var text = ""
    @Binding var tips: TipGroup
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    if !vm.isFooterExpanded {
                        CustomMenuView(selection: $vm.textContentType, titleProvider: { $0.title })
                            .popoverTip(tips.currentTip as? TextContentTypeTip)
                    } else {
                        if vm.hasStartedScanning {
                            ShareButtonView(displayScale: displayScale)
                        }
                    }
                    
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    
                    if !vm.isFooterExpanded {
                        PulsatingDots()
                            .environmentObject(vm)
                    } else {
                        if vm.hasStartedScanning {
                            Button {
                                vm.shouldScan.toggle()
                            } label: {
                                Image(systemName: vm.shouldScan ? "pause.circle.fill" : "text.viewfinder")
                                    .foregroundStyle(.white)
                                    .imageScale(.large)
                                    .font(.system(size: 32))
                                    .popoverTip(tips.currentTip as? ScanTip)
                            }
                        }
                    }
                    
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        withAnimation() {
                            vm.showExtractedText.toggle()
                            
                            rotationAngle += 180
                        }
                        rotationAngle = vm.showExtractedText ? 180 : 0
                        
                        withAnimation(.linear(duration: 0.3)) {
                            vm.isFooterExpanded.toggle()
                        }
                    }, label: {
                        Image(systemName: "chevron.up")
                            .foregroundStyle(.black)
                            .rotationEffect(Angle(degrees: rotationAngle))
                            .padding()
                            .padding(.horizontal)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.white)
                            )
                            .popoverTip(tips.currentTip as? ExpandFooterTip)
                        
                    })
                    .frame(alignment: .trailing)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            VStack(alignment: .leading, spacing: 16) {
                if vm.showExtractedText {
                    CustomSelectableTextView(text: vm.extractedText, selectedText: $vm.selectedText)
                        .frame(minWidth: 40)
                }
            }
            
            if vm.hasStartedScanning && vm.showExtractedText {
                HStack {
                    Button {
                        if vm.textContentType == .all {
                            let all = AllContent(title: "New ALL", text: vm.extractedText)
                            modelContext.insert(all)
                            save()
                        } else {
                            showAlert = true
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
                        vm.toastText = "Copied to Clipboard"
                        displayToast()
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
                .sensoryFeedback(.success, trigger: vm.toastText)
            }
            
            Spacer()
        }
        .background(.black.opacity(0.7))
        .frame(height: vm.showExtractedText ? geometry.size.height * 0.7:    geometry.size.height * 0.2)
        .alert("", isPresented: $showAlert) {
            TextField(text: $text) {}

            Button("Cancel", role: .cancel) {
                
            }
            
            Button("Submit") {
                switch vm.textContentType {
                case .all:
                    break
                case .url:
                    let url = URLContent(title: text.isEmpty ? "New URL" : text, text: vm.extractedText)
                    modelContext.insert(url)
                case .phone:
                    let phone = PhoneContent(title:  text.isEmpty ? "New phone" : text, text: vm.extractedText)
                    modelContext.insert(phone)
                case .email:
                    let email = EmailContent(title:  text.isEmpty ? "New email" : text, text: vm.extractedText)
                    modelContext.insert(email)
                case .address:
                    let address = AddressContent(title:  text.isEmpty ? "New address" : text, address: vm.extractedText)
                    modelContext.insert(address)
                }
                save()
            }
           
        } message: {
            Text("Give it a name for better organization.")
        }
        
    }
    
    private func save() {
        do {
            try modelContext.save()
            
        } catch {
            print("Error saving: \(error.localizedDescription)")
        }
        vm.toastText = "Saved"
        displayToast()
    }
    
    private func displayToast() {
        UIPasteboard.general.string = vm.preferredText
        
        withAnimation {
            vm.showToast = true
            
        }
        DispatchQueue.main.asyncAfter (deadline: .now() + 1.5) {
            withAnimation {
                vm.showToast = false
            }
        }
    }
}
