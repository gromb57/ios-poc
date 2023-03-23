//
//  NeuControl.swift
//  ios-poc
//
//  Created by Jerome Bach on 23/03/2023.
//

import Foundation
import UIKit

class NeuControl: UIControl, UIViewCodingProtocol {
    
    // MARK: - UI
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initUI() {
        // implements in subclass
    }
}
