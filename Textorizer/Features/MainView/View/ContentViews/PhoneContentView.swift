//
//  PhoneContentView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 13/02/25.
//

import SwiftUI
import SwiftData

struct PhoneContentView: View {
    @Query var items: [PhoneContent]
    @State private var showTextView: Bool = false
    @State private var selectedText: String = ""
    
    var body: some View {
        VStack {
            List {
                ForEach(items, id: \.id) { item in
                    Button {
                        showTextView = true
                        selectedText = item.text
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
