//
//  NeuSegment.swift
//  ios-poc
//
//  Created by Jerome Bach on 26/03/2023.
//

import Foundation
import UIKit

class NeuSegment: NeuControl {
    private let neuLayer = NeuLayer()
    
    var cornerRadius: CGFloat = 8 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
            self.neuLayer.cornerRadius = self.layer.cornerRadius
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.neuLayer.bounds = self.layer.bounds
        self.neuLayer.frame.origin = .zero
        self.layer.cornerRadius = self.cornerRadius
        self.neuLayer.cornerRadius = self.layer.cornerRadius
        if self.isOn {
            self.neuLayer.applyShadow(UIControl.State.highlighted)
            self.titleLabel?.textColor = self.tintColor
        } else {
            self.neuLayer.removeShadow()
            self.titleLabel?.textColor = NeuLabel.appearance().textColor
        }
    }

    // MARK: Managing the title
    private(set) lazy var titleLabel: UILabel? = {
        let titleLabel = NeuLabel(frame: self.bounds)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = NSTextAlignment.center
        self.addSubview(titleLabel)
        titleLabel.constraint(inset: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        return titleLabel
    }()
}

