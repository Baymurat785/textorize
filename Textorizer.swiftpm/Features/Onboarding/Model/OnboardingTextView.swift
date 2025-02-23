//
//  OnboardingTextView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 19/02/25.
//

import SwiftUI

struct OnboardingTextView: View {
    let text: String
    
    var body: some View {
        if #available(iOS 16.1, *) {
            Text(text)
                .font(.system(size: 24, weight: .medium))
                .fontDesign(.serif)
                .multilineTextAlignment(.center)
                .lineSpacing(10)
                .padding(.horizontal)
                .frame(alignment: .center)
                .transition(.move(edge: .top))
        } else {
            // Fallback on earlier versions
        }
    }
}
