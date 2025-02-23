//
//  Onboarding2.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 19/02/25.
//

import SwiftUI

extension OnboardingView {
    struct Onboarding2View: View {
        @State private var showImage = false
        @State private var showText = false
        @State private var showButton = false
        
        var action: () -> Void
        
        var body: some View {
            VStack {
                Spacer()
                
                if showText {
                    OnboardingTextView(text: "You can select the text\ncontent type!")
                }
                
                
                if showImage {
                    Image("onboardingImage2")
                        .resizable()
                        .frame(width: 345, height: 415)
                        .overlay(content: {
                            Rectangle()
                                .fill(.black.opacity(0.3))
                        })
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .clipped()
                }
                
                Spacer()
                
                if showButton {
                    OnboardingButtonView {
                        action()
                    }
                    .padding(.bottom, 30)
                    .transition(.move(edge: .bottom))
                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 0.6)) { showText = true }
            }
            .task {
                try? await Task.sleep(nanoseconds: 500_000_000)
                withAnimation(.easeInOut(duration: 0.6)) { showImage = true }
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                withAnimation(.easeInOut(duration: 0.6)) { showButton = true }
            }
            .frame(maxWidth: .infinity)
            .background(Rectangle().fill(.white))
            .ignoresSafeArea(edges: .bottom)
        }
    }
    
}
