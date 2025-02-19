//
//  Onboarding1View.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 19/02/25.
//

import SwiftUI

struct Onboarding1View: View {
    @State var showText = false
    @State var showImage = false
    @State var showButton = false
    @State var showNextOnboarding = false
    
    var action: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            if showText {
                OnboardingTextView(text: "Fed up with cluttered, text-heavy galleries? Discover a cleaner, more visual experience with our app.")
            }
            
            Spacer()
            
            ZStack(alignment: .bottom) {
                if showImage {
                    Group {
                        Image(.imageOnboarding)
                        
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
        .ignoresSafeArea()
        .onAppear {
            withAnimation {
                showImage = true
                showText = true
            }
        }
        .task {
            try? await Task.sleep(nanoseconds: 4_000_000_000)
            
            withAnimation {
                showButton = true
            }
        }
    }
}
