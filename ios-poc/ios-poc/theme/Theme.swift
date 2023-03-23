//
//  Theme.swift
//  ios-poc
//
//  Created by Jerome Bach on 22/03/2023.
//

import Foundation
import UIKit

struct Theme {
    var theme: ThemeType = ThemeType.light

    var mainColor: UIColor = UIColor(named: "theme/light/colors/mainColor") ?? UIColor.purple
    var bgColor: UIColor = UIColor(named: "theme/light/colors/bgColor") ?? UIColor.white

    func applyAppearance() {
        UIWindow.appearance().tintColor = self.mainColor
        
        NeuControl.appearance().backgroundColor = self.bgColor
    }
}
