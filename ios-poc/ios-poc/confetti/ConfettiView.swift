//
//  ConfettiView.swift
//  ios-poc
//
//  Created by Jerome Bach on 26/10/2024.
//
import SwiftUI

struct ConfettiView: View {
    @State var animate = false
    @State var xSpeed = Double.random(in: 0.7...2)
    @State var zSpeed = Double.random(in: 1...2)
    @State var anchor = CGFloat.random(in: 0...1).rounded()
    
    private var color: Color = {
        return [Color.orange, Color.green, Color.blue, Color.red, Color.yellow].randomElement() ?? Color.green
    }()
    
    var body: some View {
        Circle()
            .fill(self.color)
            .frame(width: 20, height: 20)
            .onAppear(perform: { self.animate = true })
            .rotation3DEffect(.degrees(self.animate ? 360 : 0), axis: (x: 1, y: 0, z: 0))
            .animation(Animation.linear(duration: self.xSpeed).repeatForever(autoreverses: false), value: self.animate)
            .rotation3DEffect(.degrees(self.animate ? 360 : 0), axis: (x: 0, y: 0, z: 1), anchor: UnitPoint(x: self.anchor, y: self.anchor))
            .animation(Animation.linear(duration: self.zSpeed).repeatForever(autoreverses: false), value: self.animate)
    }
}
