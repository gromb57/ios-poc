//
//  NeuButtonRouned.swift
//  ios-poc
//
//  Created by Jerome Bach on 23/03/2023.
//

import Foundation
import UIKit

class NeuButtonRouned: NeuButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.bounds.height / 2
    }
}
