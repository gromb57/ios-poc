//
//  ChatVC.swift
//  ios-poc
//
//  Created by Jerome Bach on 01/11/2024.
//

import Foundation
import UIKit

final class ChatVC: UIViewController {
    // MARK: View lifecyclke
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.navigationController?.navigationBar.isHidden = true
        self.initUI()
    }

    private func initUI() {
        self.view.backgroundColor = ThemeManager.currentTheme().bgColor
        
        let wrap = UIStackView()
        wrap.axis = .vertical
        self.view.addSubview(wrap)
        wrap.constraintToSafe(inset: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        
        wrap.addArrangedSubview(ChatBubbleView(state: .A))
        wrap.addArrangedSubview(ChatBubbleView(state: .B))
    }
}
