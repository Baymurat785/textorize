//
//  OnboardingButtonView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 19/02/25.
//

import SwiftUI

struct OnboardingButtonView: View {
    var text: String = "Next"
    var colorText: Color = .white
    var color: Color = .black
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .foregroundStyle(colorText)
                .padding()
                .frame(width: 300)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(color)
                )
                .padding(.horizontal, 24)
        }

    }
}
