//
//  NeuTextField.swift
//  ios-poc
//
//  Created by Jerome Bach on 25/03/2023.
//

import Foundation
import UIKit

class NeuTextField: UITextField, UIViewCodingProtocol {
    
    var insetDx: CGFloat = 16
    var insetDy: CGFloat = 4
    private var neuLayer = NeuLayer()

    // MARK: - Init
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    func initUI() {
        self.layer.backgroundColor = self.backgroundColor?.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 4)
        self.layer.shadowRadius = 3
        self.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOpacity = 0.1
        self.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.addSublayer(self.neuLayer)
        NeuLayer.applyInnerShadow(self.neuLayer, offset: 2)
        self.addAction(UIAction(handler: { _ in
            self.resignFirstResponder()
        }), for: UIControl.Event.touchUpOutside)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.neuLayer.bounds = self.layer.bounds
        self.neuLayer.frame.origin = .zero
        self.neuLayer.cornerRadius = self.layer.cornerRadius
    }

    /// placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, self.insetDx, self.insetDy)
    }

    /// text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = CGRectInset(bounds, self.insetDx, self.insetDy)
        rect.size.width -= (self.rightView?.bounds.width ?? 0)
        return rect
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x = bounds.width - (self.rightView?.bounds.width ?? 0) - self.insetDx / 2
        return rect
    }

    func setRightImage(image: UIImage?) {
        self.rightViewMode = .always
        let imageView = UIImageView(image: image)
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        self.rightView = imageView
    }
}
