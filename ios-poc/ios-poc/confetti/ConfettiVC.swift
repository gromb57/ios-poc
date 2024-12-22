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
        let vc = UIHostingController(rootView: CelebrateView().edgesIgnoringSafeArea(.all))
        if #available(iOS 16.4, *) {
            vc.safeAreaRegions = []
        } else {
            // Fallback on earlier versions
        }

        let swiftuiView = vc.view!
        swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        swiftuiView.backgroundColor = UIColor.black
        
        // Add the view controller to the destination view controller.
        self.addChild(vc)
        self.view.addSubview(swiftuiView)
        
        // Create and activate the constraints for the swiftui's view.
        swiftuiView.constraintToSafe(inset: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        
        // Notify the child view controller that the move is complete.
        vc.didMove(toParent: self)
    }
}
