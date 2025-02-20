//
//  TextView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 12/02/25.
//

import SwiftUI
import SwiftData

struct AllTextView: View {
    @Bindable var allContent: AllContent
    @Environment(\.displayScale) var displayScale
    @EnvironmentObject var vm: MainViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            TextEditor(text: $allContent.text)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .scrollIndicators(.hidden)
            
            HStack {
                if vm.selectedFileType == .text {
                    ShareLink(item: allContent.text) {
                        shareButtonIcon
                    }
                    .foregroundStyle(Color.black)

                } else {
                    ShareLink(item: PDFCreator(page: PDFInfo(text: allContent.text, date: Date())).createPDFData(displayScale: displayScale)) {
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

