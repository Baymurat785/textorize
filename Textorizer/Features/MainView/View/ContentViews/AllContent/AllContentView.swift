//
//  AllContentView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 13/02/25.
//

import SwiftUI
import SwiftData

struct AllContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \AllContent.date, order: .reverse) var items: [AllContent]
    @State private var showTextView: Bool = false
    @State private var selectedRow: AllContent?
    
    var body: some View {
        VStack {
            List {
                ForEach(items, id: \.id) { item in
                    Button {
                        showTextView = true
                        selectedRow = item
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.text.prefix(20))
                                
                                Text(item.date)
                                    .font(.subheadline)
                                    .foregroundStyle(Color.gray)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                        }
                    }
                }
                .onDelete { indexSet in
                    deleteItem(indexSet)
                }
            }
        }
        .background(Colors.main)
        .navigationDestination(isPresented: $showTextView) {
//            TextView(text: $selectedText)
            if let selectedRow {
                AllTextView(allContent: selectedRow)
            }
        }
    }
    
    func deleteItem(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = items[index]
            modelContext.delete(item)
        }
    }
}
