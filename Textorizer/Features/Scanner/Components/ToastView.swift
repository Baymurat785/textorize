//
//  ToastView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 15/02/25.
//

import SwiftUI

struct ToastView: View {
    let text: String
    
    var body: some View {
        Text("Copied to Clipboard")
            .font(.system(.body, design: .rounded, weight: .semibold))
            .foregroundStyle(.white)
            .padding()
            .background(Color.blue.clipShape(RoundedRectangle(cornerRadius: 20)))
            .padding(.bottom)
            .shadow(radius: 5)
            .transition(.move(edge: .top))
            .frame(maxHeight: .infinity, alignment: .top)
    }
}
