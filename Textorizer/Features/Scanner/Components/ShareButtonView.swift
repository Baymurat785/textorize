//
//  ShareButtonView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 18/02/25.
//

import SwiftUI

struct ShareButtonView: View {
    @EnvironmentObject var vm: MainViewModel
    let displayScale: CGFloat
    
    var body: some View {
        if vm.selectedFileType == .text {
            ShareLink(item: vm.extractedText) {
                shareButtonIcon
            }
        } else {
            ShareLink(item: PDFCreator(page: PDFInfo(text: vm.extractedText, date: Date())).createPDFData(displayScale: displayScale)) {
                shareButtonIcon
            }
        }
    }
    
    private var shareButtonIcon: some View {
        Image(systemName: "square.and.arrow.up")
            .font(.system(size: 35, weight: .medium, design: .default))
            .foregroundStyle(.white)
    }
}

