//
//  ThemeType.swift
//  ios-poc
//
//  Created by Jerome Bach on 22/03/2023.
//

import Foundation

enum ThemeType: Int {
    case light

    func instanciate() -> Theme {
        switch self {
        case .light: return Theme()
        }
    }
}
