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
    @State private var selectedAddress: AddressContent?
    
    var body: some View {
        VStack {
            List {
                ForEach(items, id: \.id) { item in
                    Button {
                        showTextView = true
                        selectedAddress = item
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
            if let selectedAddress {
                AddressTextView(address: selectedAddress)
            }
        }
    }
}

#Preview {
    AddressContentView()
}
