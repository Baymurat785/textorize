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
        Text("Change the the content type")
    }
}

struct ExpandFooterTip: Tip {
    var title: Text {
        Text("Expand the view to see scanned text")
    }
}

struct PDFTip: Tip {
    var title: Text {
        Text("Change the sharing type")
    }
}

struct ScanTip: Tip {
    var title: Text {
        Text("Press button to stop and start scanning")
    }
}
