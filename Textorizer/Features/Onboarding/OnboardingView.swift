//
//  Onboarding.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 19/02/25.
//

import SwiftUI

struct OnboardingView: View {
    @State var activeOnboarding:  OnboardingType = .first
    @EnvironmentObject var appCode: AppCore
    
    var body: some View {
        switch activeOnboarding {
        case .first:
            Onboarding1View {
                withAnimation {
                    activeOnboarding = .second
                }
            }
        case .second:
            Onboarding2View {
                withAnimation {
                    activeOnboarding = .third
                }
            }
        case .third:
            Onboarding3View {
                withAnimation {
                    activeOnboarding = .fourth
                }
            }
        case .fourth:
            Onboarding4View {
                withAnimation {
                    AppCore.shared.hasOnboardingSeen = true
                }
            }
        }
    }
}
