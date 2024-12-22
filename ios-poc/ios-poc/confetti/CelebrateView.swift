//
//  CelebrateView.swift
//  ios-poc
//
//  Created by Jerome Bach on 26/10/2024.
//
import SwiftUI

struct CelebrateView: View {
    @State private var showConfetti = false

    var body: some View {
        VStack {
            Button(self.showConfetti ? "Stop" : "Celebrate") {
                self.showConfetti = !self.showConfetti
            }.buttonStyle(.plain)
                .padding()
                .background(.white)
                .foregroundColor(.black)
        }
        .displayConfetti(isActive: self.$showConfetti)
    }
}
