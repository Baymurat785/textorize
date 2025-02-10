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
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment: .topLeading) {
            switch vm.activeView {
            case .camera:
                CameraPicker(image: $capturedImage)
                    .ignoresSafeArea()
            case .scanner:
                ScannerView()
            }
            
            VStack {
                Picker("", selection: $vm.activeView) {
                    ForEach(ViewType.allCases, id: \.self) {
                        Text($0.name).tag($0.id)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(alignment: .top)
                .padding()
                .containerRelativeFrame(.horizontal, count: 1, spacing: 1, alignment: .center)
                
            }
        }
    }
}

#Preview {
    CameraView()
}
