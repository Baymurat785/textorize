//
//  PDFView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 18/02/25.
//


import SwiftUI

struct PDFView: View {
    let info: PDFInfo
    
    var body: some View {
        VStack {
            Text(info.text)
                .font(.system(size: 14))
                .padding(.vertical, 25)
                .padding(.horizontal)

            Spacer()
            
            Text(info.date.formattedStyle())
                .multilineTextAlignment(.center)
                .padding(.vertical, 25)
                .padding(.horizontal, 40)
        }
        .frame(width: 72.0 * 11.0, height: 72.0 * 16.0)
    }
}
