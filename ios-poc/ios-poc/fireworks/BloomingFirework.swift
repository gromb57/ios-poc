//
//  BloomingFirework.swift
//  ios-poc
//
//  Created by Jerome Bach on 22/12/2024.
//

import SwiftUI

@available(iOS 17.0, *)
struct BloomingFirework: View {
  @State var time: Double = 0
  let endPoint: CGPoint
  let burstColor: Color
  
  let timer = Timer.publish(
    every: 1/120,
    on: .main,
    in: .common
  ).autoconnect()
  
  var body: some View {
    let time = time

    Color.black
      .visualEffect { view, proxy in
        view.colorEffect(
          ShaderLibrary.bundle(.main)
            .trailEffect(
              .float(time),
              .float2(proxy.size),
              .float2(endPoint),
              .color(burstColor)
            )
        )
      }
      .onReceive(timer) { _ in
        self.time += 0.016667
      }
  }
}


#Preview {
  ZStack {
    Color.black
      if #available(iOS 17.0, *) {
          BloomingFirework(time: 0.0, endPoint: .init(x: 0.2, y: 0.6), burstColor: .purple)
          BloomingFirework(time: 0.9, endPoint: .init(x: 0.7, y: 0.2), burstColor: .cyan)
          BloomingFirework(time: 0.4, endPoint: .init(x: 0.4, y: 0.3), burstColor: .red)
      } else {
          // Fallback on earlier versions
      }
  }
  .ignoresSafeArea()
}
