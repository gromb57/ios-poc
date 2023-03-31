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
    var textColor: UIColor = UIColor(named: "theme/light/colors/textColor") ?? UIColor.darkGray

    func applyAppearance() {
        self.applyWindowAppearance()
        self.applyNeuAppearance()
    }

    func applyWindowAppearance() {
        UIWindow.appearance().tintColor = self.mainColor
    }

    func applyNeuAppearance() {
        self.applyNeuButtonAppearance()
        self.applyNeuControlAppearance()
        self.applyNeuImageViewAppearance()
        self.applyNeuSliderAppearance()
        self.applyNeuTextFieldAppearance()
    }

    func applyNeuButtonAppearance() {
        NeuButton.appearance().backgroundColor = self.bgColor
        NeuButton.appearance().tintColor = self.mainColor
    }

    func applyNeuControlAppearance() {
        NeuControl.appearance().backgroundColor = self.bgColor
    }
    
    func applyNeuImageViewAppearance() {
        NeuImageView.appearance().backgroundColor = self.bgColor
    }
    
    func applyNeuSliderAppearance() {
        // Cause crash
        // NeuSlider.appearance().thumbColor = self.bgColor
    }
    
    func applyNeuTextFieldAppearance() {
        NeuTextField.appearance().backgroundColor = self.bgColor
        NeuTextField.appearance().tintColor = self.mainColor
        NeuTextField.appearance().textColor = self.textColor
    }
}
