//
//  View+ValidatedFieldModifier.swift
//  ios-poc
//
//  Created by Jerome Bach on 22/12/2024.
//

import SwiftUICore

/// An extension to easily apply the ValidatedFieldModifier.
extension View {
    func validatedField(validatedField: ValidatedField, placeholder: String) -> some View {
        self.modifier(ValidatedFieldModifier(validatedField: validatedField, placeholder: placeholder))
    }
}
