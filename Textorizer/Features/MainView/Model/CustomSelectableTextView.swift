//
//  CustomSelectableTextView.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 05/02/25.
//

import SwiftUI
import UIKit

struct CustomSelectableTextView: UIViewRepresentable {
    let text: String
    @Binding var selectedText: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = CustomTextView()
        textView.text = text
        textView.isEditable = false
        textView.isSelectable = true
        textView.backgroundColor = .clear
        textView.delegate = context.coordinator

        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CustomSelectableTextView

        init(_ parent: CustomSelectableTextView) {
            self.parent = parent
        }

        func textViewDidChangeSelection(_ textView: UITextView) {
            if let range = textView.selectedTextRange {
                parent.selectedText = textView.text(in: range) ?? ""
            }
        }
    }
}

// MARK: - CustomTextView
class CustomTextView: UITextView, UIEditMenuInteractionDelegate {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupInteraction()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInteraction()
    }

    private func setupInteraction() {
        if #available(iOS 16.0, *) {
            let interaction = UIEditMenuInteraction(delegate: self)
            addInteraction(interaction)
        }
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }

    @available(iOS 16.0, *)
    func editMenuInteraction(_ interaction: UIEditMenuInteraction, menuFor configuration: UIEditMenuConfiguration) -> UIMenu? {
        return nil // Prevents menu from appearing
    }
}
