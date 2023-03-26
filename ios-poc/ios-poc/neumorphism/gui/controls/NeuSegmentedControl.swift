//
//  NeuSegmentedControl.swift
//  ios-poc
//
//  Created by Jerome Bach on 25/03/2023.
//

import Foundation
import UIKit

class NeuSegmentedControl: NeuControl {
    private let neuLayer = NeuLayer()
    
    var cornerRadius: CGFloat = 8 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
            self.neuLayer.cornerRadius = self.layer.cornerRadius
        }
    }
    var inset: CGFloat = 4 {
        didSet {
            self.layoutSubviews()
        }
    }

    // MARK: - UI
    override func initUI() {
        self.layer.addSublayer(self.neuLayer)
        self.neuLayer.applyShadow(UIControl.State.normal)

        self.addSubview(self.stackView)
        self.stackView.constraint(inset: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.neuLayer.bounds = self.layer.bounds
        self.neuLayer.frame.origin = .zero
        self.layer.cornerRadius = self.cornerRadius
        self.neuLayer.cornerRadius = self.layer.cornerRadius
    }

    // MARK: - UISegmentedControl
    var numberOfSegments: Int = 0 {
        didSet {
            self.initSegments()
        }
    }
    var selectedSegmentIndex: Int = -1 {
        didSet {
            if oldValue > -1 && self.segments.count > oldValue {
                self.segments[oldValue].isOn = false
            }
            if self.selectedSegmentIndex > -1 && self.segments.count > self.selectedSegmentIndex {
                self.segments[self.selectedSegmentIndex].isOn = true
            }
        }
    }
    private(set) var segments: [NeuSegment] = []

    private func initSegments() {
        for _ in stride(from: self.segments.count, to: self.numberOfSegments, by: -1) {
            self.segments.removeLast()
        }
        for i in self.segments.count..<self.numberOfSegments {
            let segment = NeuSegment()
            segment.titleLabel?.text = self.titleForState(i)
            self.segments.append(segment)
            self.stackView.addArrangedSubview(segment)
            self.segments[i].addAction(UIAction(handler: { _ in
                self.selectedSegmentIndex = i
            }), for: UIControl.Event.touchUpInside)
        }
    }
    
    private(set) var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isUserInteractionEnabled = true
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
    private var titles: [Int:String?] = [:]

    func titleForState(_ index: Int) -> String? {
        return self.titles[index] ?? nil
   }

    func setTitle(_ title: String?, for index: Int) {
        self.titles[index] = title
        self.segments[index].titleLabel?.text = title
    }
}
