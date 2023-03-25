//
//  NeuButtonRounded.swift
//  ios-poc
//
//  Created by Jerome Bach on 23/03/2023.
//

import Foundation
import UIKit

class NeuButtonRounded: NeuButton {
    override func layoutSubviews() {
        self.layer.cornerRadius = self.bounds.height / 2
        super.layoutSubviews()
    }
}
