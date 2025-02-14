//
//  TabView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 10/02/25.
//

import SwiftUI
import SwiftData

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
    @State var settings = 0
    @State var home = 0

    var body: some View {
        HStack {
            //Home
            Button {
                selection = .home
                home += 1
            } label: {
                Image(systemName: "house")
//                    .foregroundStyle(.white)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(selection == .home ? .blue : .gray)
                    .padding()
//                    .background(
//                        Rectangle()
//                            .fill(selection == .home ? .blue.opacity(0.5) : .gray)
//                    )
//                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .symbolEffect(.bounce, value: home)
            
            Spacer()
            
            //camera
            Button {
                showCamera = true
            } label: {
                Image(systemName: "camera.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.blue)
//                    .background(
//                        Rectangle()
//                            .fill(.blue)
//                    )
//                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            Spacer()

            //settinga
            Button {
                selection = .settings
                settings += 1
            } label: {
                Image(systemName: "gear")
                    .resizable()
                    .frame(width: 20, height: 20)
//                    .foregroundStyle(.white)
                    .foregroundStyle(selection == .settings ? .blue : .gray)
                    .padding()
//                    .background(
//                        Rectangle()
//                            .fill(selection == .home ? .blue.opacity(0.5) : .gray)
//                    )
//                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .symbolEffect(.bounce, value: settings)

        }
        .frame(maxWidth: .infinity)
        .padding([.horizontal])
    }
}
