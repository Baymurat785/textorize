//
//  ViewEnum.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 04/02/25.
//

import Foundation

enum ViewType: String, Identifiable {
    case camera
    case scanner
    
    var id: String { self.rawValue }
}
