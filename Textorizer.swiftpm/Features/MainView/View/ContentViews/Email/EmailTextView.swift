//
//  EmailTextView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 20/02/25.
//

import SwiftUI

struct EmailTextView: View {
    @Bindable var email: EmailContent
    @Environment(\.displayScale) var displayScale
    @EnvironmentObject var vm: MainViewModel
    
    var body: some View {
        VStack {
            TextEditor(text: $email.text)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .scrollIndicators(.hidden)
            
            HStack {
                if vm.selectedFileType == .text {
                    ShareLink(item: email.text) {
                        shareButtonIcon
                    }
                    .foregroundStyle(Color.black)

                } else {
                    ShareLink(item: PDFCreator(page: PDFInfo(text: email.text, date: Date())).createPDFData(displayScale: displayScale)) {
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

