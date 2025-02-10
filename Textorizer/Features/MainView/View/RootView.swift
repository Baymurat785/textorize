//
//  TabView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 10/02/25.
//

import SwiftUI

struct RootView: View {
    @State private var selection: Tab = .home
    @EnvironmentObject var vm: MainViewModel
    
    
    var body: some View {
        VStack() {
            if selection == .home {
                MainView()
                    .environmentObject(vm)
            } else {
                SettngsView()
                    .environmentObject(vm)
            }
            
            Spacer()
            
            CustomTabView(selection: $selection, showCamera: $vm.showCamera)
        }
    }
}

// Enum for tab selection
enum Tab: Hashable {
    case home
    case settings
}




struct CustomTabView: View {
    @Binding var selection: Tab
    @Binding var showCamera: Bool
    var body: some View {
        HStack {
            //Home
            Button {
                selection = .home
            } label: {
                Image(systemName: "house")
//                    .resizable()
//                    .foregroundStyle(.white)
                    .foregroundStyle(selection == .home ? .blue : .gray)
                    .padding()
//                    .background(
//                        Rectangle()
//                            .fill(selection == .home ? .blue.opacity(0.5) : .gray)
//                    )
//                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            Spacer()
            
            //camera
            Button {
                showCamera = true
            } label: {
                Image(systemName: "camera")
                    .foregroundStyle(.white)
                    .padding()
                    .background(
                        Rectangle()
                            .fill(.blue)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            Spacer()

            //settinga
            Button {
                selection = .settings
            } label: {
                Image(systemName: "gear")
//                    .resizable()
//                    .foregroundStyle(.white)
                    .foregroundStyle(selection == .settings ? .blue : .gray)
                    .padding()
//                    .background(
//                        Rectangle()
//                            .fill(selection == .home ? .blue.opacity(0.5) : .gray)
//                    )
//                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }

        }
        .frame(maxWidth: .infinity)
        .padding([.horizontal, .top])
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue.opacity(0.1))
                .ignoresSafeArea()
        )
    }
}
