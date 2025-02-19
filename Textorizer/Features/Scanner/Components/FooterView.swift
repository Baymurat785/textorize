//
//  FooterView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 15/02/25.
//

import SwiftUI

struct FooterView: View {
    let geometry: GeometryProxy
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var vm: MainViewModel
    @Environment(\.dismiss) var dismiss
    @State var rotationAngle: Double = 0
    @Environment(\.displayScale) var displayScale
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    if !vm.showOpenedView {
                        CustomMenuView(selection: $vm.textContentType, titleProvider: { $0.title })
                    } else {
                        if vm.hasStartedScanning {
                            ShareButtonView(displayScale: displayScale)
                        }
                    }
                    
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    
                    if !vm.showOpenedView {
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
                            }
                        }
                    }
                    
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    
#warning("Fix animation")
                    Button(action: {
                        withAnimation() {
                            vm.showExtractedText.toggle()
                            
                            rotationAngle += 180
                        }
                        rotationAngle = vm.showExtractedText ? 180 : 0
                        
                        withAnimation(.linear(duration: 0.3)) {
                            vm.showOpenedView.toggle()
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
                        vm.toastText = "Saved"
                        displayToast()
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
