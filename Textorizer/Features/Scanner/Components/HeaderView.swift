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
        HStack {
            Button {
                switchTorch.toggle()
                //FIXME: This causes camera disbales when it is on
                toggleTorch(on: switchTorch)
                
            } label: {
                Image(systemName: "bolt.fill")
    //                .resizable()
                    .font(.system(size: 18,weight: .thin))
                    .foregroundStyle(switchTorch ? Color.orange : Color.black)
                    .padding(8)
                    .background(
                        Circle()
                            .fill(.white)
                    )
            }

            Spacer()
            
            if vm.showOpenedView {
                PulsatingDots()
                    .environmentObject(vm)
            }
            
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
        .padding(.horizontal)
        .padding(.top, 30)
        .frame(maxWidth: .infinity)
        .frame(height: geometry.size.height * 0.12)
        .background(.black.opacity(0.5))
    }
    
    private func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }

        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                device.torchMode = on ? .on : .off
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }

}
