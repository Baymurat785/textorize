//
//  ContentView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 29/01/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "camera")
                    .foregroundStyle(.white)
                    .padding()
                    .background(
                        Rectangle()
                            .fill(.blue)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }

        }
        .padding()
    }
}

#Preview {
    MainView()
}
