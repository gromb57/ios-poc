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
    func constraint(_ toView: UIView? = nil) {
        guard let toView = toView ?? self.superview else {
            return
        }

        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: toView.topAnchor),
            self.bottomAnchor.constraint(equalTo: toView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: toView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: toView.trailingAnchor)
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
