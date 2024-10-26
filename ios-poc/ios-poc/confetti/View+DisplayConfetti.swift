//
//  View+DisplayConfetti.swift
//  ios-poc
//
//  Created by Jerome Bach on 26/10/2024.
//
import SwiftUI

extension View {
    func displayConfetti(isActive: Binding<Bool>) -> some View {
        self.modifier(DisplayConfettiModifier(isActive: isActive))
    }
}
