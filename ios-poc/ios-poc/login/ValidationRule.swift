//
//  ValidationRule.swift
//  ios-poc
//
//  Created by Jerome Bach on 22/12/2024.
//

import Foundation

/// A protocol that defines a validation rule for a specific type of input.
protocol ValidationRule {
    associatedtype Input
    
    /// Validates the given input.
    /// - Parameter input: The input to validate.
    /// - Returns: An optional error message if validation fails.
    func validate(_ input: Input) -> String?
}
