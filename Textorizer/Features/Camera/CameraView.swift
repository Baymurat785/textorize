//
//  CameraView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 30/01/25.
//

import SwiftUI

struct CameraView: View {
    @EnvironmentObject var vm: MainViewModel
    @State private var capturedImage: UIImage?
    
    var body: some View {
        VStack {
            
        }
        .task {
            await vm.requestAccess()
        }
//        CameraPicker(image: $capturedImage)
//            .ignoresSafeArea()
    }
}

#Preview {
    CameraView()
}
