//
//  PDFCreator.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 18/02/25.
//

import SwiftUI
import PDFKit

class PDFCreator {
    let page: PDFInfo
    
#warning("Fix the namings")
    private let metaData = [
        kCGPDFContextAuthor: "Textorize",
        kCGPDFContextSubject: "Textorize"
    ]
    
    
    private var rect: CGRect {
        return CGRect(x: 0, y: 0, width: 11.0 * 72.0, height:  72.0 * 16.0)
    }
    
    init(page: PDFInfo) {
        self.page = page
    }
    
    @MainActor
    func createPDFData(displayScale: CGFloat) -> URL {
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = metaData as [String : Any]
        let renderer = UIGraphicsPDFRenderer(bounds: rect, format: format)
        
        let tempFolder = FileManager.default.temporaryDirectory
        let fileName = "My Custom PDF Title.pdf"
        let tempURL = tempFolder.appendingPathComponent(fileName)
        
        try? renderer.writePDF(to: tempURL) { context in
            context.beginPage()
            let imageRenderer = ImageRenderer(content: PDFView(info: page))
            imageRenderer.scale = displayScale
            imageRenderer.uiImage?.draw(at: CGPoint.zero)
        }
        
        return tempURL
    }
}
