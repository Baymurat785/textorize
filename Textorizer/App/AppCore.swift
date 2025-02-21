//
//  AppCore.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 19/02/25.
//

import Foundation
import SwiftUI

final class AppCore: ObservableObject {
    private init() {}
    static let shared = AppCore()
    
    @AppStorage(Keys.hasOnboardingSeen)
    var hasOnboardingSeen: Bool = false
    
    @AppStorage(Keys.hasTipsSeen)
    var hasTipsSeen: Bool = false
    
    enum Keys {
        static let hasOnboardingSeen = "hasOnboardingSeen"
        static let hasTipsSeen = "hasTipsSeen"
    }
}
