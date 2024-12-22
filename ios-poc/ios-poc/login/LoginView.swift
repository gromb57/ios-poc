//
//  LoginView.swift
//  ios-poc
//
//  Created by Jerome Bach on 22/12/2024.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        VStack(spacing: 20) {
            // Email Field
            TextField("Email", text: $viewModel.email.value)
                .validatedField(validatedField: viewModel.email, placeholder: "Email")
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            // Password Field
            SecureField("Password", text: $viewModel.password.value)
                .validatedField(validatedField: viewModel.password, placeholder: "Password")
            
            // Login Button
            Button(action: {
                viewModel.login()
            }) {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.canSubmit ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(!viewModel.canSubmit)
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
