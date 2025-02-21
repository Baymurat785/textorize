//
//  SwiftUIView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 19/02/25.
//

import SwiftUI

struct Onboarding4View: View {
    @State private var showText = false
    @State private var showButton = false
    
    var action: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            if showText {
                OnboardingTextView(text: "Your gallery is a place\nfor cherished memories,\nnot for information.")
                    .transition(.move(edge: .top))
            }
            Spacer()
            
            if showButton {
                OnboardingButtonView(text: "Start using app") {
                    withAnimation {
                        action()
                    }
                }
                .padding(.bottom, 30)
                .transition(.move(edge: .bottom))
                
            }
        }
        .ignoresSafeArea()
        .task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)

            withAnimation {
                showText = true
            }

            try? await Task.sleep(nanoseconds: 2_000_000_000)
            withAnimation {
                showButton = true
            }
        }
        .background(
            Rectangle()
                .fill(.white)
        )
        .transition(.move(edge: .trailing))
    }
}
