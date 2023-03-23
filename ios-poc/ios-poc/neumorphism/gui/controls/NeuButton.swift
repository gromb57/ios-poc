//
//  NeuButton.swift
//  ios-poc
//
//  Created by Jerome Bach on 23/03/2023.
//

import Foundation
import UIKit

class NeuButton: NeuControl {

    private var neuLayer = NeuLayer()
    
    // MARK: - UI
    override func initUI() {
        self.layer.insertSublayer(self.neuLayer, below: self.layer)
        self.neuLayer.applyShadow(self.state)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.neuLayer.bounds = self.layer.bounds
        self.neuLayer.frame.origin = .zero
    }

    // MARK: - Event
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        
    }
}
