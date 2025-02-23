//
//  EmailContentView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 13/02/25.
//

import SwiftUI
import SwiftData

struct EmailContentView: View {
    @Query var items: [EmailContent]
    @State private var showTextView: Bool = false
    @State private var selectedEmail: EmailContent?
    
    var body: some View {
        VStack {
            List {
                ForEach(items, id: \.id) { item in
                    Button {
                        showTextView = true
                        selectedEmail = item
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
            if let selectedEmail {
                EmailTextView(email: selectedEmail)
            }
        }
    }
}

#Preview {
    EmailContentView()
}
