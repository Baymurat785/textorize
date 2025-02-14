//
//  AddressContentView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 13/02/25.
//

import SwiftUI
import SwiftData

struct AddressContentView: View {
    @Query var items: [AddressContent]
    @State private var showTextView: Bool = false
    @State private var selectedText: String = ""
    
    var body: some View {
        VStack {
            List {
                ForEach(items, id: \.id) { item in
                    Button {
                        showTextView = true
                        selectedText = item.address
                    } label: {
                        Text(item.title)
                    }
                }
            }
        }
        .background(Colors.main)
        .navigationDestination(isPresented: $showTextView) {
            TextView(text: $selectedText)
        }
    }
}

#Preview {
    AddressContentView()
}
