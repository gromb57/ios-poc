//
//  AnyValidationRule.swift
//  ios-poc
//
//  Created by Jerome Bach on 22/12/2024.
//

/// A type-erased wrapper for any ValidationRule.
struct AnyValidationRule<Input>: ValidationRule {
    private let _validate: (Input) -> String?
    
    /// Initializes the type-erased validation rule with a specific ValidationRule.
    /// - Parameter rule: The validation rule to wrap.
    init<R: ValidationRule>(_ rule: R) where R.Input == Input {
        self._validate = rule.validate
    }
    
    /// Validates the input using the encapsulated validation rule.
    /// - Parameter input: The input to validate.
    /// - Returns: An optional error message if validation fails.
    func validate(_ input: Input) -> String? {
        return _validate(input)
    }
}
