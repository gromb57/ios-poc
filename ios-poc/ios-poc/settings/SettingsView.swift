//
//  SettingsView.swift
//  ios-poc
//
//  Created by Jerome Bach on 22/12/2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var userDefaultsViewModel: UserDefaultsViewModel

    var body: some View {
        VStack(spacing: 40) {
            TextField("Enter your name", text: $userDefaultsViewModel.name)
                .textFieldStyle(.roundedBorder)
            
            Toggle(
                userDefaultsViewModel.isToggleOn ? "toggle ON" : "Toggle OFF",
                systemImage: userDefaultsViewModel.isToggleOn ? "lightbulb.fill" : "lightbulb",
                isOn: $userDefaultsViewModel.isToggleOn
            )
        }
        .font(.title)
        .padding(.horizontal, 40)
    }
}

#Preview {
    SettingsView()
}
