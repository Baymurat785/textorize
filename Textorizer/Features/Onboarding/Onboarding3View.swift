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
                OnboardingTextView(text: "Easily copy or save any scanned or selected text")
            }
            
            Spacer()
           
            ZStack(alignment: .bottom) {
                if showImage {
                    Group {
                        Image(.onboardingImage3)
                        
                        Image(.phoneOnboarding)
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
        .transition(.move(edge: .trailing))
        .ignoresSafeArea()
        .onAppear {
            withAnimation {
                showImage = true
                showText = true
            }
        }
        .task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            
            withAnimation {
                showButton = true
            }
        }

    }
}
