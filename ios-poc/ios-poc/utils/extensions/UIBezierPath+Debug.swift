//
//  UIBezierPath+Debug.swift
//  ios-poc
//
//  Created by Jerome Bach on 26/03/2023.
//

import Foundation
import UIKit

extension UIBezierPath {
    private func addDot(_ layer: CALayer, to point: CGPoint, color: CGColor) {
        let circle = CALayer()
        circle.bounds = CGRect(origin: .zero, size: CGSize(width: 4, height: 4))
        circle.frame.origin = CGPoint(x: point.x - 2, y: point.y - 2)
        circle.backgroundColor = color
        circle.cornerRadius = 2
        layer.addSublayer(circle)
    }

    /// Use to debug by placing a dot on point
    /// - Parameters:
    ///   - layer: debug layer
    ///   - point: point
    func move(_ layer: CALayer, to point: CGPoint) {
        self.addDot(layer, to: point, color: CGColor(red: 255, green: 0, blue: 0, alpha: 1))
        self.move(to: point)
    }
    
    func addLine(_ layer: CALayer, to point: CGPoint, color: CGColor? = nil) {
        self.addDot(layer, to: point, color: color ?? CGColor(red: 0, green: 0, blue: 255, alpha: 1))
        self.addLine(to: point)
    }

    func addArc(_ layer: CALayer, withCenter: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) {
        self.addDot(layer, to: withCenter, color: CGColor(red: 0, green: 255, blue: 0, alpha: 1))
        self.addArc(withCenter: withCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        self.addDot(layer, to: self.currentPoint, color: CGColor(red: 255, green: 255, blue: 0, alpha: 1))
    }
}
