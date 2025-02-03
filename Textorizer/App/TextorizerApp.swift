//
//  TextorizerApp.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 29/01/25.
//

import SwiftUI

@main
struct TextorizerApp: App {
    @StateObject private var vm = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(vm)
                .task {
                    await vm.requestAccess()
                }
        }
    }
}
