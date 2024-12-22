//
//  ValidatedFieldModifier.swift
//  ios-poc
//
//  Created by Jerome Bach on 22/12/2024.
//

import SwiftUICore

/// A view modifier that attaches validation to a TextField.
struct ValidatedFieldModifier: ViewModifier {
    @ObservedObject var validatedField: ValidatedField
    let placeholder: String
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            content
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(validatedField.error == nil ? Color.gray : Color.red, lineWidth: 1)
                )
            
            if let error = validatedField.error {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }
}
