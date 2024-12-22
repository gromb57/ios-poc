//
//  SettingsVC.swift
//  ios-poc
//
//  Created by Jerome Bach on 26/10/2024.
//

import Foundation
import UIKit
import SwiftUI

final class SettingsVC: UIViewController {
    @ViewBuilder
    private var contentView: some View {
        SettingsView()
            .environmentObject((UIApplication.shared.currentWindow!.windowScene!.delegate as! SceneDelegate).userDefaultsVM)
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
