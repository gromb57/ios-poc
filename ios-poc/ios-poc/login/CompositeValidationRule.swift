//
//  CompositeValidationRule.swift
//  ios-poc
//
//  Created by Jerome Bach on 22/12/2024.
//

/// A validation rule that combines multiple validation rules.
struct CompositeValidationRule<Input>: ValidationRule {
    typealias Input = Input
    
    private let rules: [AnyValidationRule<Input>]
    
    /// Initializes the CompositeValidationRule with an array of validation rules.
    /// - Parameter rules: The validation rules to combine.
    init(rules: [AnyValidationRule<Input>]) {
        self.rules = rules
    }
    
    func validate(_ input: Input) -> String? {
        for rule in rules {
            if let error = rule.validate(input) {
                return error
            }
        }
        return nil
    }
}
