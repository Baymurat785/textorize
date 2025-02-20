//
//  URLTextView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 20/02/25.
//



import SwiftUI
import SwiftData

struct URLTextView: View {
    @Bindable var url: URLContent
    @EnvironmentObject var vm: MainViewModel
    @Environment(\.displayScale) var displayScale
    
    var body: some View {
        VStack {
            TextEditor(text: $url.text)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .scrollIndicators(.hidden)
            
            HStack {
                if vm.selectedFileType == .text {
                    ShareLink(item: url.text) {
                        shareButtonIcon
                    }
                    .foregroundStyle(Color.black)

                } else {
                    ShareLink(item: PDFCreator(page: PDFInfo(text: url.text, date: Date())).createPDFData(displayScale: displayScale)) {
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

