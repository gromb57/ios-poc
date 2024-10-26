//
//  ConfettiVC.swift
//  ios-poc
//
//  Created by Jerome Bach on 26/10/2024.
//

import Foundation
import UIKit
import SwiftUI

final class ConfettiVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    private func initUI() {
        // create hosting controller
        let vc = UIHostingController(rootView: CelebrateView())

        let swiftuiView = vc.view!
        swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the view controller to the destination view controller.
        self.addChild(vc)
        self.view.addSubview(swiftuiView)
        
        // Create and activate the constraints for the swiftui's view.
        NSLayoutConstraint.activate([
            swiftuiView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            swiftuiView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
        
        // Notify the child view controller that the move is complete.
        vc.didMove(toParent: self)
    }
}
