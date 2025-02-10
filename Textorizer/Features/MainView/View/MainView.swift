//
//  ContentView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 29/01/25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var vm: MainViewModel
    var body: some View {
        VStack {
            Spacer()
            
            Text("Main Screen")
                .font(.largeTitle)
        }
        .padding()
    }
}
