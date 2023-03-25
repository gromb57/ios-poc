//
//  NeuLayer.swift
//  ios-poc
//
//  Created by Jerome Bach on 23/03/2023.
//

import Foundation
import UIKit

class NeuLayer: CALayer {
    enum Corner: String {
        case TopLeft = "Neu-TopLeftName"
        case BottomRight = "Neu-BottomRightName"

        var offset: CGFloat {
            switch self {
            case .TopLeft: return 1
            case .BottomRight: return -1
            }
        }
    }

    enum Layers: String {
        case Container = "Neu-Container"
    }

    override func layoutSublayers() {
        super.layoutSublayers()

        self.sublayers?.forEach({ layer in
            layer.bounds = self.bounds
            layer.frame.origin = .zero
            layer.masksToBounds = false
            if let corner = Corner(rawValue: layer.name ?? "") {
                layer.shadowPath = type(of: self).path(layer, for: corner, offset: layer.shadowOffset).cgPath
            }
        })
    }

    func applyShadow(_ state: UIControl.State = .normal) {
        type(of: self).applyShadow(self, for: state)
    }
    
    // MARK: - Statics Properties
    static let lightColor = UIColor.white
    static let darkColor = UIColor(red: 0.82, green: 0.80, blue: 0.78, alpha: 1.00) // #D1CDC7
    static let borderColor = UIColor(white: 1, alpha: 0.2)
    
    // MARK: - Shadow
    static func applyShadow(_ layer: CALayer, for state: UIControl.State = .normal) {
        switch state {
        case .highlighted:
            self.applyInnerShadow(layer)
            layer.borderWidth = 0
        default:
            layer.borderColor = self.borderColor.cgColor
            layer.borderWidth = 1
            self.applyOutterShadow(layer)
        }
    }

    static func applyOutterShadow(_ layer: CALayer) {
        // top left
        self.applyOutterShadow(layer, corner: Corner.TopLeft, color: NeuLayer.lightColor.cgColor)

        // bottom right
        self.applyOutterShadow(layer, corner: Corner.BottomRight, color: NeuLayer.darkColor.cgColor)
    }

    static func applyOutterShadow(_ layer: CALayer, corner: Corner, color: CGColor) {
        var subLayer: CALayer
        if let sub = layer.sublayers?.first(where: { layer in
            return layer.name == corner.rawValue
        }) {
            subLayer = sub
        } else {
            subLayer = CALayer()
            subLayer.bounds = layer.bounds
            subLayer.name = corner.rawValue
            layer.insertSublayer(subLayer, below: layer)
        }
        //subLayer.masksToBounds = false
        subLayer.shadowColor = color
        subLayer.shadowRadius = abs(corner.offset)
        subLayer.shadowOpacity = 1
        subLayer.shadowOffset = CGSize(width: corner.offset, height: corner.offset)
        subLayer.shadowPath = self.path(layer, for: corner, offset: subLayer.shadowOffset).cgPath
    }

    static func applyInnerShadow(_ layer: CALayer, offset: CGFloat? = nil) {
        // top left
        self.applyInnerShadow(layer, corner: Corner.TopLeft, color: NeuLayer.darkColor.cgColor, offset: offset ?? Corner.TopLeft.offset)

        // bottom right
        self.applyInnerShadow(layer, corner: Corner.BottomRight, color: NeuLayer.lightColor.cgColor, offset: offset?.negate() ?? Corner.BottomRight.offset)
    }

    static func applyInnerShadow(_ layer: CALayer, corner: Corner, color: CGColor, offset: CGFloat) {
        var subLayer: CALayer
        if let sub = layer.sublayers?.first(where: { layer in
            return layer.name == corner.rawValue
        }) {
            subLayer = sub
        } else {
            subLayer = CALayer()
            subLayer.bounds = layer.bounds
            subLayer.name = corner.rawValue
            layer.insertSublayer(subLayer, below: layer)
        }
        //subLayer.masksToBounds = false
        subLayer.shadowColor = color
        subLayer.shadowRadius = abs(offset)
        subLayer.shadowOpacity = 1
        subLayer.shadowOffset = CGSize(width: offset, height: offset)
        subLayer.shadowPath = self.path(layer, for: corner, offset: subLayer.shadowOffset).cgPath
    }

    // MARK: - Path
    static func path(_ layer: CALayer, for corner: Corner, offset: CGSize) -> UIBezierPath {
        let cornerRadius = layer.superlayer?.cornerRadius ?? 0
        let path = UIBezierPath()
        path.move(to: CGPoint(x: layer.bounds.minX, y: layer.bounds.maxY))
        switch corner {
        case .TopLeft:
            path.addLine(to: CGPoint(x: layer.bounds.minX, y: layer.bounds.minY))
            path.addLine(to: CGPoint(x: layer.bounds.maxX, y: layer.bounds.minY))
            path.addLine(to: CGPoint(x: layer.bounds.maxX, y: layer.bounds.minY + offset.height))
            path.addLine(to: CGPoint(x: layer.bounds.minX + offset.width, y: layer.bounds.minY + offset.height))
            path.addLine(to: CGPoint(x: layer.bounds.minX + offset.width, y: layer.bounds.maxY))
            break
        case .BottomRight:
            path.addLine(to: CGPoint(x: layer.bounds.maxX, y: layer.bounds.maxY))
            path.addLine(to: CGPoint(x: layer.bounds.maxX, y: layer.bounds.minY))
            path.addLine(to: CGPoint(x: layer.bounds.maxX + offset.width, y: layer.bounds.minY))
            path.addLine(to: CGPoint(x: layer.bounds.maxX + offset.width, y: layer.bounds.maxY + offset.height))
            path.addLine(to: CGPoint(x: layer.bounds.minX, y: layer.bounds.maxY + offset.height))
            break
        }
        path.close()
        return path
    }
}
