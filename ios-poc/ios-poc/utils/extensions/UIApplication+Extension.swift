//
//  UIApplication+Extension.swift
//  ios-poc
//
//  Created by Jerome Bach on 22/12/2024.
//

import UIKit

extension UIApplication {
    var currentWindow: UIWindow? {
        connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first
    }
}
