//
//  UIScrollView+Constraints.swift
//  ios-poc
//
//  Created by Jerome Bach on 22/03/2023.
//

import Foundation
import UIKit

extension UIScrollView {
    /// Constraint subView to self
    /// - Parameter subView: UIView? = nil, if nil use superview
    func constraint(subView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: self.topAnchor),
            subView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            subView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func constraintVertically(subView: UIView) {
        NSLayoutConstraint.activate([
            self.contentLayoutGuide.heightAnchor.constraint(equalTo: subView.heightAnchor)
        ])
    }
    
    func constraintHorizontally(subView: UIView) {
        NSLayoutConstraint.activate([
            self.contentLayoutGuide.widthAnchor.constraint(equalTo: subView.widthAnchor)
        ])
    }
}
