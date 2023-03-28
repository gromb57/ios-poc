//
//  NeuCheckbox.swift
//  ios-poc
//
//  Created by Jerome Bach on 25/03/2023.
//

import Foundation
import UIKit

class NeuCheckbox: NeuControl {
    private let neuLayer = NeuLayer()
    private let switchLayer = NeuLayer()
    
    var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
            self.neuLayer.cornerRadius = self.layer.cornerRadius
        }
    }
    var inset: CGFloat = 4 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    var isOn: Bool = false {
        didSet {
            self.setNeedsLayout()
            self.sendActions(for: UIControl.Event.valueChanged)
        }
    }

    // MARK: - UI
    override func initUI() {
        self.layer.addSublayer(self.neuLayer)
        self.neuLayer.applyShadow(UIControl.State.highlighted)
        
        self.layer.addSublayer(self.switchLayer)
        self.switchLayer.applyShadow(UIControl.State.normal)
        
        self.addAction(UIAction(handler: { _ in
            self.isOn = !self.isOn
        }), for: UIControl.Event.touchUpInside)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let dim: CGFloat = min(self.layer.bounds.width, self.layer.bounds.height)
        self.neuLayer.bounds = CGRect(origin: .zero, size: CGSize(width: dim, height: dim))
        self.neuLayer.frame.origin = .zero
        self.neuLayer.cornerRadius = self.layer.cornerRadius
        self.neuLayer.backgroundColor = self.isOn ? self.tintColor.cgColor : CGColor(gray: 0, alpha: 0)
        
        let innerDim: CGFloat = self.layer.bounds.height - inset * 2
        self.switchLayer.bounds = CGRect(origin: .zero, size: CGSize(width: innerDim, height: innerDim))
        self.switchLayer.frame.origin = CGPoint(x: inset, y: inset)
        self.switchLayer.cornerRadius = self.cornerRadius - inset
        self.switchLayer.backgroundColor = ThemeManager.currentTheme().bgColor.cgColor
    }
}
