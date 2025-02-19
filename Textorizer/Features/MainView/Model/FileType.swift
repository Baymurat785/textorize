//
//  FileType.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 17/02/25.
//

import Foundation

enum FileType: String, CaseIterable, Identifiable {
    case pdf
    case text
    
    var id: String { self.rawValue }
    
    var title: String {
        switch self {
        case .pdf:
            "PDF"
        case .text:
            "Text"
        }
    }
}
