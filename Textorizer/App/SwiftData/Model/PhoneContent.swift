//
//  PhoneContent.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 13/02/25.
//


import SwiftData
import Foundation

@Model
final class PhoneContent {
    var id = UUID()
    var title: String
    var text: String
    var date: String = Date().formattedStyle()
    
    init(title: String, text: String) {
        self.title = title
        self.text = text
    }
}

 
