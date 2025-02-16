//
//  CustomMenuView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 15/02/25.
//

import SwiftUI

struct CustomMenuView: View {
    @Binding var selection: TextContentTypeOption
    var body: some View {
        Menu {
            ForEach(TextContentTypeOption.allCases) { type in
                Button {
                    selection = type
                } label: {
                    Text(type.title)
                        .font(.system(size: 14.0, weight: .medium, design: .default))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                }
                
            }
        } label: {
            Text(selection.title)
                .font(.system(size: 14.0, weight: .medium, design: .default))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                )
        }
        
    }
}
//
//#Preview {
//    CustomMenuView()
//}
