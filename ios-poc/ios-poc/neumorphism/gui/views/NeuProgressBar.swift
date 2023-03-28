//
//  NeuProgressBar.swift
//  ios-poc
//
//  Created by Jerome Bach on 25/03/2023.
//

import Foundation
import UIKit

class NeuProgressBar: UIView, UIViewCodingProtocol {
    
    private var neuLayer = NeuLayer()
    private var progressLayer = CALayer()

    var inset: CGFloat = 4

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
        self.progressLayer.cornerRadius = self.neuLayer.cornerRadius - self.inset
        self.progressLayer.bounds = CGRect(origin: .zero, size: CGSize(width: (self.layer.bounds.width - self.inset * 2) * CGFloat(self.progress), height: self.layer.bounds.height - self.inset * 2))
        self.progressLayer.frame.origin = CGPoint(x: self.inset, y: self.inset)
    }

    func initUI() {
        self.layer.insertSublayer(self.neuLayer, below: self.layer)
        self.neuLayer.applyShadow()
        self.layer.insertSublayer(self.progressLayer, above: self.neuLayer)
        self.progressLayer.backgroundColor = self.tintColor.cgColor
    }

    // MARK: - Progress
    /// The current progress is represented by a floating-point value between 0.0 and 1.0, inclusive, where 1.0 indicates the completion of the task. The default value is 0.0. Values less than 0.0 and greater than 1.0 are pinned to those limits.
    var progress: Float = 0 {
        didSet {
            if self.progress < 0 {
                self.progress = 0
            } else if self.progress > 1 {
                self.progress = 1
            }
            self.setNeedsLayout()
        }
    }
}
