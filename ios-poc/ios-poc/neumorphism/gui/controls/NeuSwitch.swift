//
//  NeuSwitch.swift
//  ios-poc
//
//  Created by Jerome Bach on 25/03/2023.
//

import Foundation
import UIKit

class NeuSwitch: NeuControl {
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
            self.layoutSubviews()
        }
    }
    
    var isOn: Bool = false {
        didSet {
            self.layoutSubviews()
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

        self.neuLayer.bounds = CGRect(origin: .zero, size: CGSize(width: self.layer.bounds.height * 2, height: self.layer.bounds.height))
        self.neuLayer.frame.origin = .zero
        self.neuLayer.cornerRadius = self.layer.cornerRadius
        self.neuLayer.backgroundColor = self.isOn ? self.tintColor.cgColor : CGColor(gray: 0, alpha: 0)
        
        let innerDim: CGFloat = self.layer.bounds.height - inset * 2
        self.switchLayer.bounds = CGRect(origin: .zero, size: CGSize(width: innerDim, height: innerDim))
        if self.isOn {
            self.switchLayer.frame.origin = CGPoint(x: inset * 3 + innerDim, y: inset)
        } else {
            self.switchLayer.frame.origin = CGPoint(x: inset, y: inset)
        }
        self.switchLayer.cornerRadius = self.cornerRadius - inset
        self.switchLayer.backgroundColor = ThemeManager.currentTheme().bgColor.cgColor
    }
}
