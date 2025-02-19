//
//  HeaderView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 15/02/25.
//

import SwiftUI
import AVFoundation

struct HeaderView: View {
    @EnvironmentObject var vm: MainViewModel
    let geometry: GeometryProxy
    var dismiss: () -> Void
    @State var switchTorch = false
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                
                CustomMenuView(selection: $vm.selectedFileType, titleProvider: { $0.title })
                
                Spacer()
            }
            
            HStack {
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                    //                .resizable()
                        .font(.system(size: 18,weight: .regular))
                        .foregroundStyle(Color.black)
                        .padding(8)
                        .background(
                            Circle()
                                .fill(.white)
                        )
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 30)
        .frame(maxWidth: .infinity)
        .frame(height: geometry.size.height * 0.12)
        .background(.black.opacity(0.5))
    }
    
    func toggleTorch(on: Bool) {
        DispatchQueue.main.async {
            guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else {
                print("Torch is not available")
                return
            }
            
            do {
                try device.lockForConfiguration()
                device.torchMode = on ? .on : .off
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used: \(error.localizedDescription)")
            }
        }
    }
}
