//
//  Onboarding3View.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 19/02/25.
//

import SwiftUI

struct Onboarding3View: View {
    @State private var showText = true
    @State private var showImage = false
    @State private var showButton = false
    
    var action: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            if showText {
                OnboardingTextView(text: "Easily copy or save any\nscanned or selected text")
            }
            
            Spacer()
           
            ZStack(alignment: .bottom) {
                if showImage {
                    Group {
                        Image("onboardingImage3")
                        
                        Image("phone-onboarding")
                    }
                    .transition(.move(edge: .bottom))
                }
                
                if showButton {
                    OnboardingButtonView(colorText: .black,    color: .white) {
                        withAnimation {
                            action()
                        }
                    }
                    .padding(.bottom, 30)
                    .transition(.move(edge: .bottom))
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeInOut(duration: 0.8)) {
                showImage = true
            }
        }
        .task {
            try? await Task.sleep(nanoseconds: 800_000_000)
            withAnimation(.easeInOut(duration: 0.5)) {
                showButton = true
            }
        }
        .background(
            Rectangle()
                .fill(.white)
        )
    }
}
