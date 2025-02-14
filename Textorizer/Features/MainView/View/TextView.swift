//
//  TextView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 12/02/25.
//

import SwiftUI

struct TextView: View {
    @Binding var text: String
    
    var body: some View {
        VStack {
            TextEditor(text: $text)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
                .scrollIndicators(.hidden)
        }
        .background(Colors.main)
    }
}

