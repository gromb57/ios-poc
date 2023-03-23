//
//  NeuVC.swift
//  ios-poc
//
//  Created by Jerome Bach on 22/03/2023.
//

import Foundation
import UIKit

final class NeuVC: UIViewController {

    var scrollView: UIScrollView!
    var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
    }

    private func initUI() {
        self.view.backgroundColor = ThemeManager.currentTheme().bgColor

        self.scrollView = UIScrollView()
        // self.scrollView.backgroundColor = .blue

        self.stackView = UIStackView()
        // self.stackView.backgroundColor = .red
        self.stackView.axis = NSLayoutConstraint.Axis.vertical
        self.stackView.distribution = UIStackView.Distribution.fillProportionally
        self.stackView.spacing = 10

        self.addGuis()
        
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.stackView)

        self.scrollView.constraint()
        self.scrollView.constraint(subView: self.stackView)
    }

    private func addGuis() {
        let button = NeuButton(frame: .zero)
        //button.setTitle("Button", for: .normal)
        button.constraint(size: CGSize(width: CGFloat.nan, height: 44))
        self.addGui(view: button)
        
        let button2 = NeuButtonRouned(frame: .zero)
        //button2.setTitle("Button 2", for: .normal)
        button2.constraint(size: CGSize(width: CGFloat.nan, height: 88))
        self.addGui(view: button2)

        let view = UIView()
        view.constraint(size: CGSize(width: CGFloat.nan, height: 1024))
        view.backgroundColor = .purple
        self.addGui(view: view)
    }

    private func addGui(view: UIView) {
        let wrapper = UIView()
        wrapper.addSubview(view)
        view.constraint(inset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        self.stackView.addArrangedSubview(wrapper)
    }
}
