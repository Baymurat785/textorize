//
//  CustomMenuView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 15/02/25.
//

import SwiftUI

//Made this generic with the help of ChatGPT
struct CustomMenuView<T: CaseIterable & Identifiable>: View where T.AllCases: RandomAccessCollection {
    @Binding var selection: T
    let titleProvider: (T) -> String
    var backgroundColor: Color = .white
    var colorText: Color = .black
    
    var body: some View {
        Menu {
            ForEach(T.allCases) { option in
                Button {
                    selection = option
                } label: {
                    Text(titleProvider(option))
                        .font(.system(size: 14.0, weight: .medium, design: .default))
                        .foregroundColor(colorText)
                        .multilineTextAlignment(.leading)
                }
            }
        } label: {
            Text(titleProvider(selection))
                .font(.system(size: 14.0, weight: .medium, design: .default))
                .foregroundColor(colorText)
                .multilineTextAlignment(.leading)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(backgroundColor)
                )
        }
    }
}
