//
//  URLContentView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 13/02/25.
//

import SwiftUI
import SwiftData

struct URLContentView: View {
    @Query var items: [URLContent]
    @State private var showTextView: Bool = false
    @State private var selectedURL: URLContent?
    
    var body: some View {
        VStack {
            List {
                ForEach(items, id: \.id) { item in
                    Button {
                        showTextView = true
                        selectedURL = item
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.title)

                                Text(item.date)
                                    .font(.subheadline)
                                    .foregroundStyle(Color.gray)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                        }
                    }
                }
            }
        }
        .background(Colors.main)
        .navigationDestination(isPresented: $showTextView) {
            if let selectedURL {
                URLTextView(url: selectedURL)
            }
        }
    }
}

#Preview {
    URLContentView()
}
