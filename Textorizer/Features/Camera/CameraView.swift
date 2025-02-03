//
//  CameraView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 03/02/25.
//

import SwiftUI

struct CameraView: View {
    @EnvironmentObject var vm: MainViewModel
    @State private var capturedImage: UIImage?

    var body: some View {
        CameraPicker(image: $capturedImage)
            .ignoresSafeArea()
    }
}

#Preview {
    CameraView()
}
