//
//  ViewEnum.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 04/02/25.
//

import Foundation

enum ViewType: String, Identifiable, CaseIterable {
    case camera
    case scanner
    
    var id: String { self.rawValue }
    
    var name: String {
        switch self {
        case .scanner: "Scanner"
        case .camera: "Camera"
        }
    }
}
