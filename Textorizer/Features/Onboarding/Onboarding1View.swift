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
                OnboardingTextView(text: "Fed up with cluttered,\ntext-heavy galleries?\nDiscover a cleaner, more\nvisual experience with \nour app.")
            }
            
            Spacer()
            
            ZStack(alignment: .bottom) {
                if showImage {
                    Group {                        
                        Image("image-onboarding")
                        
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
                showText = true
                showImage = true
            }
        }
        .task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            withAnimation(.easeInOut(duration: 0.6)) {
                showButton = true
            }
        }
    }
}
