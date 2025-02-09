//
//  File.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 09/02/25.
//

import VisionKit

extension RecognizedItem: Equatable {
    public static func == (lhs: RecognizedItem, rhs: RecognizedItem) -> Bool {
        return lhs.id == rhs.id
    }
}
