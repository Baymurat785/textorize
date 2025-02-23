//
//  HeaderView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 15/02/25.
//

import SwiftUI
import AVFoundation
import TipKit

struct HeaderView: View {
    @EnvironmentObject var vm: MainViewModel
    let geometry: GeometryProxy
    var dismiss: () -> Void
    @Binding var tips: TipGroup
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                
                CustomMenuView(selection: $vm.selectedFileType, titleProvider: { $0.title })
                    .popoverTip(tips.currentTip as? PDFTip)
                
                Spacer()
            }
            
            HStack {
                Spacer()
                
                Button {
                    vm.reset()
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
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
}
