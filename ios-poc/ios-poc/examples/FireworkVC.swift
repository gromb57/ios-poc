//
//  FireworkVC.swift
//  ios-poc
//
//  Created by Jerome Bach on 26/10/2024.
//

import Foundation
import UIKit
import SwiftUI

final class FireworkVC: UIViewController {
    @ViewBuilder
    private var contentView: some View {
        ZStack {
            Color.black
            if #available(iOS 17.0, *) {
                BloomingFirework(time: 0.0, endPoint: .init(x: 0.2, y: 0.6), burstColor: .purple)
                BloomingFirework(time: 0.9, endPoint: .init(x: 0.7, y: 0.2), burstColor: .cyan)
                BloomingFirework(time: 0.4, endPoint: .init(x: 0.4, y: 0.3), burstColor: .red)
            } else {
                // Fallback on earlier versions
                Text("Needs iOS 17.0")
                    .colorInvert()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = ThemeManager.currentTheme().bgColor
        self.initUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    private func initUI() {
        // create hosting controller
        let vc = UIHostingController(rootView: self.contentView)

        let swiftuiView = vc.view!
        swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the view controller to the destination view controller.
        self.addChild(vc)
        self.view.addSubview(swiftuiView)
        
        // Create and activate the constraints for the swiftui's view.
        swiftuiView.constraintToSafe(inset: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        
        // Notify the child view controller that the move is complete.
        vc.didMove(toParent: self)
    }
}
