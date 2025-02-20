//
//  AddressContent.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 13/02/25.
//

import SwiftData
import Foundation

@Model
final class AddressContent {
    var id: UUID = UUID()
    var title: String
    var address: String
    var date: String = Date().formattedStyle()

    init(title: String, address: String) {
        self.title = title
        self.address = address
    }
}
