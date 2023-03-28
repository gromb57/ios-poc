//
//  NeuCard.swift
//  ios-poc
//
//  Created by Jerome Bach on 25/03/2023.
//

import Foundation
import UIKit

class NeuCard: UIView, UIViewCodingProtocol {
    
    private var neuLayer = NeuLayer()

    // MARK: - UI
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initUI() {
        self.layer.insertSublayer(self.neuLayer, below: self.layer)
        self.neuLayer.applyShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.neuLayer.bounds = self.layer.bounds
        self.neuLayer.frame.origin = .zero
        self.neuLayer.cornerRadius = self.layer.cornerRadius
    }
}
