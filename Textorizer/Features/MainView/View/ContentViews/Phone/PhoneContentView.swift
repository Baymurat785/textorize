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
    @State private var selectedPhone: PhoneContent?
    
    var body: some View {
        VStack {
            List {
                ForEach(items, id: \.id) { item in
                    Button {
                        showTextView = true
                        selectedPhone = item
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
            if let selectedPhone {
                PhoneTextView(phone: selectedPhone)
            }
        }
    }

}
