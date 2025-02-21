//
//  TextorizerApp.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 29/01/25.
//

import SwiftUI
import SwiftData
import TipKit

@main
struct TextorizerApp: App {
    @StateObject private var vm = MainViewModel()
    @StateObject var appCore = AppCore.shared
    @State private var hasOnboardingSeen = false
    
    var body: some Scene {
        WindowGroup {
            if appCore.hasOnboardingSeen {
                MainView()
                    .environmentObject(vm)
                    .fullScreenCover(isPresented: $vm.showCamera) {
                        ScannerView()
                            .environmentObject(vm)
                    }
                    .modelContainer(for: [AddressContent.self, AllContent.self, EmailContent.self, PhoneContent.self, URLContent.self])
            } else {
                OnboardingView()
            }
        }
    }
    
    init() {
        try? Tips.configure()
    }
}
