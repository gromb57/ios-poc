//
//  UIView+Constraints.swift
//  ios-poc
//
//  Created by Jerome Bach on 22/03/2023.
//

import Foundation
import UIKit

extension UIView {
    /// Constraint self to another view
    /// - Parameter toView: UIView? = nil, if nil use superview
    func constraint(_ toView: UIView? = nil, inset: UIEdgeInsets = .zero) {
        guard let toView = toView ?? self.superview else {
            return
        }

        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: toView.topAnchor, constant: inset.top),
            self.bottomAnchor.constraint(equalTo: toView.bottomAnchor, constant: -inset.bottom),
            self.leadingAnchor.constraint(equalTo: toView.leadingAnchor, constant: inset.left),
            self.trailingAnchor.constraint(equalTo: toView.trailingAnchor, constant: -inset.right)
        ])
    }

    func constraint(size: CGSize) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if size.height.isNormal {
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: size.height)
            ])
        }
        if size.width.isNormal {
            NSLayoutConstraint.activate([
                self.widthAnchor.constraint(equalToConstant: size.width)
            ])
        }
    }
}
