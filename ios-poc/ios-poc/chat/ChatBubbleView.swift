//
//  ChatBubbleView.swift
//  ios-poc
//
//  Created by Jerome Bach on 01/11/2024.
//

import UIKit

// TODO : test TextKit 2 (https://developer.apple.com/documentation/uikit/textkit/using_textkit_2_to_interact_with_text)
final class ChatBubbleView: UIView {
    enum State {
        case A
        case B
    }
    
    let mock: String = "blabla <a href=\"https://www.apple.com/\">click</a> end<br/>line2 <a href=\"tel://+33102030405\">tel</a><br/>line3<br/>line4<br/>line5<br/>line6<br/>"
    
    // MARK: - UI
    convenience init(state: State) {
        self.init(frame: .zero)
        
        switch state {
        case .A:
            self.initUIA()
        case .B:
            self.initUIB()
        }
    }

    required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initUIA() {
        let textview = UITextView(usingTextLayoutManager: false)
        textview.dataDetectorTypes = [.link, .phoneNumber]
        textview.text = mock
        textview.isEditable = false
        textview.delegate = self
        
        self.addSubview(textview)
        textview.constraint()
        textview.heightAnchor.constraint(equalToConstant: 64.0).isActive = true
    }
    
    func initUIB() {
        let textview = UITextView(usingTextLayoutManager: false)
        let attributedString: NSAttributedString = try! NSAttributedString(data: self.mock.data(using: String.Encoding.unicode)!, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
        textview.attributedText = attributedString
        textview.isEditable = false
        textview.isScrollEnabled = true
        textview.delegate = self
        
        self.addSubview(textview)
        textview.constraint()
        textview.heightAnchor.constraint(equalToConstant: 64.0).isActive = true
    }
}

extension ChatBubbleView: UITextViewDelegate {
    func textView(_: UITextView, shouldInteractWith: NSTextAttachment, in: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
    
    func textView(
        _ textView: UITextView,
        shouldInteractWith URL: URL,
        in characterRange: NSRange,
        interaction: UITextItemInteraction
    ) -> Bool {
        if URL.absoluteString.starts(with: "tel") {
            textView.backgroundColor = .green
        } else if URL.absoluteString.starts(with: "http") {
            textView.backgroundColor = .blue
        }
        return false
    }
    
    func textView(
        _ textView: UITextView,
        shouldInteractWith textAttachment: NSTextAttachment,
        in characterRange: NSRange
    ) -> Bool {
        return true
    }
    
    
}
