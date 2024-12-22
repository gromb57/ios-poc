//
//  SpecialCharacterValidationRule.swift
//  ios-poc
//
//  Created by Jerome Bach on 22/12/2024.
//

import Foundation

/// A validation rule that checks if a string contains at least one special character.
struct SpecialCharacterValidationRule: ValidationRule {
    typealias Input = String
    
    let errorMessage: String
    
    /// Initializes the SpecialCharacterValidationRule with a custom error message.
    /// - Parameter errorMessage: The message to display if validation fails.
    init(errorMessage: String = "Password must contain at least one special character.") {
        self.errorMessage = errorMessage
    }
    
    func validate(_ input: String) -> String? {
        let specialCharacterRegex = #".*[!@#$%^&*(),.?":{}|<>].*"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegex)
        return predicate.evaluate(with: input) ? nil : errorMessage
    }
}
