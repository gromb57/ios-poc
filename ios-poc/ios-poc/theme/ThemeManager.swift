//
//  ThemeManager.swift
//  ios-poc
//
//  Created by Jerome Bach on 22/03/2023.
//

import Foundation
import UIKit

struct ThemeManager {
    static let selectedThemeKey = "SelectedTheme"

    static func currentTheme() -> Theme {
        if let storedTheme = UserDefaults.standard.value(forKey: self.selectedThemeKey) as? Int {
            return ThemeType(rawValue: storedTheme)?.instanciate() ?? Theme()
        } else {
            return Theme()
        }
    }

    static func applyTheme(_ theme: Theme) {
        UserDefaults.standard.setValue(theme.theme.rawValue, forKey: self.selectedThemeKey)
        UserDefaults.standard.synchronize()

        UIApplication.shared.delegate?.window??.tintColor = theme.mainColor
        theme.applyAppearance()
    }
}
