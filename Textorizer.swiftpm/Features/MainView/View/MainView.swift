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
    @Namespace var animation
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Button {
                    showItemsView = true
                    selectedType = .all
                } label: {
                    HStack(alignment: .top) {
                        Text(TextContentTypeOption.all.title)
                            .font(.system(size: 24))
                            .foregroundStyle(.black)
                            .padding()
                        
                        Spacer()
                    }
                    .containerRelativeFrame(.vertical) { height, _ in
                        height * 0.2
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .matchedTransitionSource(id: TextContentTypeOption.all.id, in: animation)
                    
                }

                Spacer()
                
                VStack(spacing: 20) {
                    //this is becoming complex
                    ForEach(Array(TextContentTypeOption.allCases.dropFirst().enumerated()), id: \.element.id) {  index, type in
                        Button {
                            showItemsView = true
                            selectedType = type
                        } label: {
                            
                            VStack {
                                HStack {
                                    Text(type.title)
                                        .font(.system(size: 14))
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                    
                                }
                                .foregroundStyle(Color.black)
                                
                                if index != 3 {
                                    Divider()
                                        .padding(.horizontal, 4)
                                }
                            }
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        vm.showScanner = true
                    } label: {
                        Image(systemName: "text.viewfinder")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.white)
                            .padding()
                            .background(
                                Rectangle()
                                    .fill(.blue)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                    }
                }
            }
            .padding()
            .navigationDestination(isPresented: $showItemsView) {
                switch selectedType {
                case .all:
                    AllContentView()
                        .navigationTransition(.zoom(sourceID: TextContentTypeOption.all.id, in: animation))
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
