//
//  UserDefaultsViewModel.swift
//  ios-poc
//
//  Created by Jerome Bach on 22/12/2024.
//

import Foundation
import SwiftUI

final class UserDefaultsViewModel: ObservableObject {
    @AppStorage(Keys.isToggleOn.id) var isToggleOn: Bool = false
    @AppStorage(Keys.name.id) var name: String = ""
    
    enum Keys {
        case isToggleOn
        case name
        
        var id: String {
            "\(self)"
        }
    }
}
