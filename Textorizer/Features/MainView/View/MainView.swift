//
//  ContentView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 29/01/25.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @EnvironmentObject var vm: MainViewModel
    @State var selectedType: TextContentTypeOption?
    @State var showItemsView = false
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                List {
                    ForEach(TextContentTypeOption.allCases, id: \.id) { type in
                        Button {
                            showItemsView = true
                            selectedType = type
                        } label: {
                            HStack {
                                Text(type.title)
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $showItemsView) {
#warning("There is boilerplate code: i wanted to use predicate filter query but it caused app to freeze")

                switch selectedType {
                case .all:
                    AllContentView()
                case .url:
                    URLContentView()
                case .phone:
                    PhoneContentView()
                case .email:
                    EmailContentView()
                case .address:
                    AddressContentView()
                case nil: Text("")
                }
            }
            .background(Colors.main)
        }
    }
}
