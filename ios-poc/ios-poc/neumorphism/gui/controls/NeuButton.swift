//
//  NeuButton.swift
//  ios-poc
//
//  Created by Jerome Bach on 23/03/2023.
//

import Foundation
import UIKit

class NeuButton: NeuControl {

    private let neuLayer = NeuLayer()

    override var isEnabled: Bool {
        didSet {
            self.onStateChange()
        }
    }

    override var isHighlighted: Bool {
        didSet {
            self.onStateChange()
        }
    }

    override var isSelected: Bool {
        didSet {
            self.onStateChange()
        }
    }

    // MARK: - UI
    override func initUI() {
        self.layer.addSublayer(self.neuLayer)
        self.neuLayer.applyShadow(self.state)
        self.addSubview(self.stackView)
        self.stackView.constraint()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.neuLayer.bounds = self.layer.bounds
        self.neuLayer.frame.origin = .zero
        self.neuLayer.cornerRadius = self.layer.cornerRadius
    }

    // MARK: - State
    func onStateChange() {
        self.alpha = self.isEnabled ? 1.0 : 0.5
        self.isUserInteractionEnabled = self.isEnabled
        self.backgroundColor = self.isSelected ? NeuButton.appearance().tintColor : NeuButton.appearance().backgroundColor
        if self.hasImage {
            self.imageView?.tintColor = self.isSelected ? NeuButton.appearance().backgroundColor : NeuButton.appearance().tintColor
            self.imageView?.image = self.imageForState(self.state)
        }
        if self.hasTitle {
            self.titleLabel?.text = self.titleForState(self.state)
        }
        self.neuLayer.applyShadow(self.state)
    }
    
    // MARK: - Event
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        
    }

    // MARK: - UIButton
    private(set) var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isUserInteractionEnabled = false
        stackView.alignment = UIStackView.Alignment.fill
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fillProportionally
        stackView.spacing = 6
        return stackView
    }()

    // MARK: Managing the title
    private(set) lazy var titleLabel: UILabel? = {
        let titleLabel = NeuLabel(frame: self.stackView.bounds)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = NSTextAlignment.center
        self.stackView.addArrangedSubview(titleLabel)
        return titleLabel
    }()
    private var titles: [UIControl.State.RawValue:String?] = [:]
    
    private var hasTitle: Bool {
        return self.titles.count > 0
    }

    func titleForState(_ state: UIControl.State) -> String? {
        return (self.titles[state.rawValue] ?? self.titles[UIControl.State.normal.rawValue]) ?? nil
   }

    func setTitle(_ title: String?, for state: UIControl.State) {
        self.titles[state.rawValue] = title
        self.titleLabel?.text = self.titleForState(state)
    }

    // MARK: Managing the image
    private(set) lazy var imageView: UIImageView? = {
        let imageView = UIImageView(frame: self.stackView.bounds)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        self.stackView.addArrangedSubview(imageView)
        return imageView
    }()
    private var images: [UIControl.State.RawValue:UIImage?] = [:]
    var imageInset: CGFloat = -6

    private var hasImage: Bool {
        return self.images.count > 0
    }
    
    func imageForState(_ state: UIControl.State) -> UIImage? {
        return (self.images[state.rawValue] ?? self.images[UIControl.State.normal.rawValue]) ?? nil
    }

    func setImage(_ image: UIImage?, for state: UIControl.State) {
        self.images[state.rawValue] = image?.withAlignmentRectInsets(UIEdgeInsets(top: imageInset, left: imageInset, bottom: imageInset, right: imageInset))
        self.imageView?.image = self.imageForState(UIControl.State.normal)
    }
}
