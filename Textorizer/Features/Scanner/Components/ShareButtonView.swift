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
    var color: Color = .white
    
    var body: some View {
        if vm.selectedFileType == .text {
            ShareLink(item: vm.extractedText) {
                shareButtonIcon
            }
            .foregroundStyle(color)

        } else {
            ShareLink(item: PDFCreator(page: PDFInfo(text: vm.extractedText, date: Date())).createPDFData(displayScale: displayScale)) {
                shareButtonIcon
            }
            .foregroundStyle(color)
        }
    }
    
    private var shareButtonIcon: some View {
        Image(systemName: "square.and.arrow.up")
            .font(.system(size: 35, weight: .medium, design: .default))
            .foregroundStyle(.white)
    }
}

