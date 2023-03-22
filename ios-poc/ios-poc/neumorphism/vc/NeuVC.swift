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
        self.scrollView = UIScrollView()
        self.scrollView.backgroundColor = .blue

        self.stackView = UIStackView()
        self.stackView.backgroundColor = .red
        self.stackView.axis = NSLayoutConstraint.Axis.vertical
        self.stackView.distribution = UIStackView.Distribution.fillProportionally

        self.addGuis()
        
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.stackView)

        self.scrollView.constraint()
        self.scrollView.constraint(subView: self.stackView)
    }

    private func addGuis() {
        let button = UIButton(type: .custom)
        button.setTitle("Button", for: .normal)
        button.constraint(size: CGSize(width: CGFloat.nan, height: 44))
        self.stackView.addArrangedSubview(button)
        
        let button2 = UIButton(type: .custom)
        button2.constraint(size: CGSize(width: CGFloat.nan, height: 88))
        button2.setTitle("Button 2", for: .normal)
        self.stackView.addArrangedSubview(button2)

        let view = UIView()
        view.constraint(size: CGSize(width: CGFloat.nan, height: 1024))
        view.backgroundColor = .purple
        self.stackView.addArrangedSubview(view)
    }
}
