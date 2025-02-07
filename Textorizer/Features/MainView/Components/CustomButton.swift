//
//  CustomButton.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 04/02/25.
//

import SwiftUI

struct CustomButton: View {
    let systemImageName: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: systemImageName)
                .foregroundStyle(.white)
                .padding()
                .background(
                    Rectangle()
                        .fill(.blue)
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}
