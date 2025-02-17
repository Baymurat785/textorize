//
//  TextContentTypeOption.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 11/02/25.
//

import Foundation
import VisionKit
import SwiftData

enum TextContentTypeOption: String, CaseIterable, Identifiable {
    case all = "all"
    case url = "url"
    case phone = "phone"
    case email = "email"
    case address = "address"
    
    var id: String { self.rawValue }

    var scannerType: DataScannerViewController.TextContentType? {
        switch self {
        case .all:
            return nil
        case .url:
            return .URL
        case .phone:
            return .telephoneNumber
        case .email:
            return .emailAddress
        case .address:
            return .fullStreetAddress
        }
    }
    
    var title: String {
        switch self {
        case .all:
            "All"
        case .url:
            "URL"
        case .phone:
            "Phone"
        case .email:
            "Email"
        case .address:
            "Address"
        }
    }
}
