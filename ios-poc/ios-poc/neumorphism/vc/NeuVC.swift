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
        button.setTitle("Button", for: .normal)
        button.constraint(size: CGSize(width: CGFloat.nan, height: 44))
        self.addGui(view: button)
        
        let button2 = NeuButton(frame: .zero)
        button2.setTitle("Button 2", for: .normal)
        button2.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button2.constraint(size: CGSize(width: CGFloat.nan, height: 44))
        self.addGui(view: button2)
        
        let button3 = NeuButtonRounded(frame: .zero)
        button3.ratio = 4
        button3.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button3.constraint(size: CGSize(width: CGFloat.nan, height: 88))
        self.addGui(view: button3)

        let card = NeuCard(frame: .zero)
        card.constraint(size: CGSize(width: CGFloat.nan, height: 44))
        self.addGui(view: card)
        let buttonStack = UIStackView()
        buttonStack.alignment = .center
        buttonStack.axis = .horizontal
        buttonStack.distribution = .equalCentering
        buttonStack.spacing = 6
        card.addSubview(buttonStack)
        buttonStack.constraint(inset: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))
        let button4 = NeuButtonRounded(frame: .zero)
        button4.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        button4.constraint(size: CGSize(width: 32, height: 32))
        buttonStack.addArrangedSubview(button4)
        let button5 = NeuButtonRounded(frame: .zero)
        button5.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        button5.constraint(size: CGSize(width: 32, height: 32))
        buttonStack.addArrangedSubview(button5)
        let button6 = NeuButtonRounded(frame: .zero)
        button6.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button6.constraint(size: CGSize(width: 32, height: 32))
        buttonStack.addArrangedSubview(button6)
        let button7 = NeuButtonRounded(frame: .zero)
        button7.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        button7.constraint(size: CGSize(width: 32, height: 32))
        buttonStack.addArrangedSubview(button7)

        let textField = NeuTextField(frame: .zero)
        textField.placeholder = "Input..."
        textField.constraint(size: CGSize(width: CGFloat.nan, height: 44))
        self.addGui(view: textField)
        
        let textField2 = NeuTextField(frame: .zero)
        textField2.placeholder = "Input2..."
        textField2.layer.cornerRadius = 22
        textField2.insetDx = 24
        textField2.setRightImage(image: UIImage(systemName: "magnifyingglass"))
        textField2.constraint(size: CGSize(width: CGFloat.nan, height: 44))
        self.addGui(view: textField2)

        let checkbox = NeuCheckbox(frame: .zero)
        checkbox.constraint(size: CGSize(width: CGFloat.nan, height: 44))
        self.addGui(view: checkbox)
        
        let radio = NeuRadio(frame: .zero)
        radio.constraint(size: CGSize(width: CGFloat.nan, height: 44))
        self.addGui(view: radio)
        
        let segmentedControl = NeuSegmentedControl(frame: .zero)
        segmentedControl.numberOfSegments = 4
        segmentedControl.setTitle("Segment 1", for: 0)
        segmentedControl.setTitle("Segment 2", for: 1)
        segmentedControl.setTitle("Segment 3", for: 2)
        segmentedControl.setTitle("Segment 4", for: 3)
        segmentedControl.constraint(size: CGSize(width: CGFloat.nan, height: 44))
        self.addGui(view: segmentedControl)
        
        let aSwitch = NeuSwitch(frame: .zero)
        aSwitch.constraint(size: CGSize(width: CGFloat.nan, height: 44))
        self.addGui(view: aSwitch)
        
        let progressBar = NeuProgressBar(frame: .zero)
        progressBar.constraint(size: CGSize(width: CGFloat.nan, height: 16))
        self.addGui(view: progressBar)
        
        let slider = NeuSlider(frame: .zero)
        slider.constraint(size: CGSize(width: CGFloat.nan, height: 44))
        self.addGui(view: slider)

        let view = NeuCard()
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
