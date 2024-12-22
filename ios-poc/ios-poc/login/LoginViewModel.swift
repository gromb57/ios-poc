//
//  LoginViewModel.swift
//  ios-poc
//
//  Created by Jerome Bach on 22/12/2024.
//

import SwiftUI
import Combine

/// A view model for handling login form state and validation.
class LoginViewModel: ObservableObject {
    @Published var email: ValidatedField
    @Published var password: ValidatedField
    @Published var canSubmit: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Define validation rules for email.
        let emailRules: [AnyValidationRule<String>] = [
            AnyValidationRule(EmptyValidationRule()),
            AnyValidationRule(EmailValidationRule())
        ]
        
        // Define validation rules for password.
        let passwordRules: [AnyValidationRule<String>] = [
            AnyValidationRule(EmptyValidationRule(errorMessage: "Password cannot be empty.")),
            AnyValidationRule(SpecialCharacterValidationRule())
        ]
        
        // Initialize ValidatedFields with respective rules.
        self.email = ValidatedField(validationRules: emailRules)
        self.password = ValidatedField(validationRules: passwordRules)
        
        setupSubmitValidation()
    }
    
    /// Sets up the logic to determine if the form can be submitted.
    private func setupSubmitValidation() {
        Publishers.CombineLatest(email.$error, password.$error)
            .map { emailError, passwordError in
                return emailError == nil && passwordError == nil && !self.email.value.isEmpty && !self.password.value.isEmpty
            }
            .assign(to: \.canSubmit, on: self)
            .store(in: &cancellables)
    }
    
    /// Handles the login action.
    func login() {
        // Implement login logic here.
        print("Logging in with Email: \(email.value) and Password: \(password.value)")
    }
}
