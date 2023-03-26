//
//  NeuButtonRounded.swift
//  ios-poc
//
//  Created by Jerome Bach on 23/03/2023.
//

import Foundation
import UIKit

class NeuButtonRounded: NeuButton {
    var ratio: CGFloat = 2

    override func layoutSubviews() {
        self.layer.cornerRadius = self.bounds.height / self.ratio
        super.layoutSubviews()
    }
}
