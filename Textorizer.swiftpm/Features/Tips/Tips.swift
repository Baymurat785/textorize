//
//  TextContentTypeTip.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 21/02/25.
//

import Foundation
import TipKit

struct TextContentTypeTip: Tip {
    var title: Text {
        Text("Change the content type")
    }
}

struct ExpandFooterTip: Tip {
    var title: Text {
        Text("Expand the view to see the scanned text")
    }
}

struct PDFTip: Tip {
    var title: Text {
        Text("Change the sharing method")
    }
}

struct ScanTip: Tip {
    var title: Text {
        Text("Press the button to start or stop scanning")
    }
}

struct DeleteTip: Tip {
    @Parameter
    static var reachedThresholdParameter: Bool = false
    
    var title: Text {
        Text("Swipe a row to delete it")
    }
    
    var rules: [Rule] {
        [
            #Rule(Self.$reachedThresholdParameter) { parameter in
                parameter == true
            }
        ]
    }
}
