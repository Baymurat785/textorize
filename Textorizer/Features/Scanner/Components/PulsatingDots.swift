//
//  PulsatingDots.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 15/02/25.
//

import SwiftUI
//Created with the help of Chat GPT
struct PulsatingDots: View {
    @State private var animate = false
    @EnvironmentObject var vm: MainViewModel

    var body: some View {
        HStack() {
            if vm.extractedItems.count == 0 {
                ForEach(0..<3) { index in
                    Circle()
                        .frame(width: 14, height: 14)
                        .foregroundStyle(.black)
                        .padding(.vertical)
                        .padding(.horizontal, 6)
                        .opacity(animate ? 0.3 : 1)
                        .animation(Animation.easeInOut(duration: 0.8).repeatForever().delay(0.2 * Double(index)), value: animate)
                    
                }
            } else {
                Text("^[\(vm.extractedItems.count) item](inflect: true)")
                    .font(.system(size: 14.0, weight: .medium, design: .default))
                    .foregroundStyle(.black)
                    .padding(.vertical)
                    .padding(.horizontal, 6)
            }
        }
        .onAppear {
            animate.toggle()
        }
        .padding(.horizontal, 10)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
        )
    }
}
