//
//  PhoneTextView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 20/02/25.
//

import SwiftUI
import SwiftData

struct PhoneTextView: View {
    @Bindable var phone: PhoneContent
    @EnvironmentObject var vm: MainViewModel
    @Environment(\.displayScale) var displayScale
    
    var body: some View {
        VStack {
            TextEditor(text: $phone.text)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .scrollIndicators(.hidden)
            
            HStack {
                if vm.selectedFileType == .text {
                    ShareLink(item: phone.text) {
                        shareButtonIcon
                    }
                    .foregroundStyle(Color.black)

                } else {
                    ShareLink(item: PDFCreator(page: PDFInfo(text: phone.text, date: Date())).createPDFData(displayScale: displayScale)) {
                        shareButtonIcon
                    }
                }
                
                Spacer()
                                
                CustomMenuView(selection: $vm.selectedFileType, titleProvider: { $0.title }, backgroundColor: .black, colorText: .white)
            }
        }
        .padding()
        .background(Colors.main)
    }
    
    private var shareButtonIcon: some View {
        Image(systemName: "square.and.arrow.up")
            .font(.system(size: 35, weight: .light, design: .default))
            .foregroundStyle(.black)
    }
}

