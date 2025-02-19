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
    
    
    
    enum Keys {
        static let hasOnboardingSeen = "hasOnboardingSeen"
    }
}
