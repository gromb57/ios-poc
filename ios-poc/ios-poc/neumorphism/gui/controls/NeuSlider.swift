//
//  NeuSlider.swift
//  ios-poc
//
//  Created by Jerome Bach on 25/03/2023.
//

import Foundation
import UIKit

class NeuSlider: UIControl, UIViewCodingProtocol {
        
    private var neuLayer = NeuLayer()
    private var trackLayer = CAShapeLayer()
    private let thumbLayer = NeuLayer()

    var inset: CGFloat = 4
    var thumbDimRatio: CGFloat = 1
    var thumbAspectRatio: CGFloat = 1
    private let thumbOffset: CGFloat = 12.0

    // MARK: - UI
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.neuLayer.bounds = self.layer.bounds
        self.neuLayer.frame.origin = .zero
        self.neuLayer.cornerRadius = self.layer.cornerRadius
        
        self.updateTrackStyle()
        self.updateThumbStyle()
        self.updateThumbPosition()
    }

    func initUI() {
        self.layer.insertSublayer(self.neuLayer, below: self.layer)
        self.neuLayer.applyShadow()
        self.layer.insertSublayer(self.trackLayer, above: self.neuLayer)
        self.trackLayer.backgroundColor = self.tintColor.cgColor
        self.layer.insertSublayer(self.thumbLayer, above: self.trackLayer)
    }

    private func updateTrackStyle() {
        self.trackLayer.cornerRadius = self.layer.cornerRadius - self.inset
        self.trackLayer.bounds = CGRect(origin: .zero, size: CGSize(width: (self.layer.bounds.width * CGFloat(self.value)) - self.inset * 2, height: self.layer.bounds.height - self.inset * 2))
        self.trackLayer.frame.origin = CGPoint(x: self.inset, y: self.inset)
    }
    
    private func updateThumbStyle() {
        let dim = min(self.layer.bounds.width, self.layer.bounds.height) * self.thumbDimRatio
        self.thumbLayer.bounds = CGRect(origin: .zero, size: CGSize(width: dim * self.thumbAspectRatio, height: dim))
        self.thumbLayer.applyShadow()
        self.thumbLayer.backgroundColor = self.thumbColor?.cgColor
        self.thumbLayer.cornerRadius = self.layer.cornerRadius == 0 ? 0 : (dim / 2)
    }
    
    private func updateThumbPosition() {
        let thumbRadius: CGFloat = self.thumbLayer.bounds.width
        let trackWidth = self.layer.bounds.width - thumbRadius
        let thumbPosition = self.thumbOffset  + (self.value - self.minimumValue) * trackWidth / (self.maximumValue - self.minimumValue)
        //self.thumbLayer.position = CGPoint(x: thumbPosition, y: bounds.midY)
        self.thumbLayer.frame.origin = CGPoint(x: thumbPosition - self.inset * 2, y: (self.layer.bounds.height - self.thumbLayer.bounds.height) / 2)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchLocation = touch.location(in: self)
        let thumbRadius: CGFloat = self.thumbLayer.bounds.width
        let trackWidth = bounds.width - self.thumbOffset - thumbRadius
        let newValue = minimumValue + (self.maximumValue - self.minimumValue) * (touchLocation.x - thumbOffset) / trackWidth
        
        // disable implicit animations
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.value = max(min(newValue, self.maximumValue), self.minimumValue)
        CATransaction.commit()
        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        if !self.isContinuous {
            sendActions(for: .valueChanged)
        }
    }
    
    // MARK: - Slider
    var minimumValue: CGFloat = 0
    var maximumValue: CGFloat = 1
    var isContinuous: Bool = true
    var value: CGFloat = 0.5 {
        didSet {
            self.setNeedsLayout()
            if self.isContinuous {
                sendActions(for: .valueChanged)
            }
        }
    }
    var thumbColor: UIColor? = UIColor.white
}
