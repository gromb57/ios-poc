//
//  ClockVC.swift
//  ios-poc
//
//  Created by Jerome Bach on 31/03/2023.
//

import Foundation
import UIKit

final class ClockVC: UIViewController {
    
    var timer: Timer?

    let clockView: UIView = {
        let view = UIView()
        return view
    }()

    let outerLayer = NeuLayer()
    let borderLayer = NeuLayer()
    let midLayer = NeuLayer()
    let hourLayer = CAShapeLayer()
    let minuteLayer = CAShapeLayer()
    let secondsLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
    }
    
    deinit {
        self.timer?.invalidate()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.clockView.layer.cornerRadius = self.clockView.bounds.height / 2
        
        self.outerLayer.bounds = self.clockView.bounds
        self.outerLayer.frame.origin = .zero
        self.outerLayer.cornerRadius = self.clockView.layer.cornerRadius

        let borderDim: CGFloat = 10
        self.borderLayer.bounds = CGRect(origin: .zero, size: CGSize(width: self.outerLayer.bounds.size.width - borderDim * 2, height: self.outerLayer.bounds.size.height - borderDim * 2))
        self.borderLayer.frame.origin = CGPoint(x: borderDim, y: borderDim)
        self.borderLayer.cornerRadius = max(0, self.outerLayer.cornerRadius - borderDim)
    
        let midDim: CGFloat = self.outerLayer.bounds.size.width / 2
        self.midLayer.bounds = CGRect(origin: .zero, size: CGSize(width: midDim, height: midDim))
        self.midLayer.frame.origin = CGPoint(x: midDim / 2, y: midDim / 2)
        self.midLayer.cornerRadius = max(0, self.outerLayer.cornerRadius - midDim / 2)

        self.hourLayer.bounds = self.midLayer.bounds
        self.hourLayer.frame = self.midLayer.frame
        self.hourLayer.lineCap = .round
        self.hourLayer.lineWidth = 2
        self.hourLayer.strokeColor = UIColor.red.cgColor
        self.hourLayer.path = {
            let bezier = UIBezierPath()
            bezier.move(to: CGPoint(x: self.midLayer.bounds.midX, y: self.midLayer.bounds.midY))
            bezier.addLine(to: CGPoint(x: self.midLayer.bounds.midX, y: 0))
            return bezier.cgPath
        }()
        
        self.minuteLayer.bounds = self.clockView.bounds
        self.minuteLayer.frame.origin = .zero
        self.minuteLayer.lineCap = .round
        self.minuteLayer.lineWidth = 2
        self.minuteLayer.strokeColor = UIColor.blue.cgColor
        self.minuteLayer.path = {
            let bezier = UIBezierPath()
            bezier.move(to: CGPoint(x: self.outerLayer.bounds.midX, y: self.outerLayer.bounds.midY))
            bezier.addLine(to: CGPoint(x: self.outerLayer.bounds.midX, y: borderDim * 2))
            return bezier.cgPath
        }()
        
        self.secondsLayer.bounds = self.clockView.bounds
        self.secondsLayer.frame.origin = .zero
        self.secondsLayer.lineCap = .round
        self.secondsLayer.lineWidth = 1
        self.secondsLayer.strokeColor = UIColor.purple.cgColor
        self.secondsLayer.path = {
            let bezier = UIBezierPath()
            bezier.move(to: CGPoint(x: self.outerLayer.bounds.midX, y: self.outerLayer.bounds.midY))
            bezier.addLine(to: CGPoint(x: self.outerLayer.bounds.midX, y: borderDim))
            return bezier.cgPath
        }()
        self.setTime()
    }

    private func initUI() {
        self.view.backgroundColor = ThemeManager.currentTheme().bgColor
        
        self.view.addSubview(self.clockView)
        self.clockView.translatesAutoresizingMaskIntoConstraints = false
        self.clockView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -40).isActive = true
        self.clockView.heightAnchor.constraint(equalTo: self.clockView.widthAnchor, multiplier: 1).isActive = true
        self.clockView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.clockView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        self.outerLayer.applyShadow(UIControl.State.normal)
        self.clockView.layer.addSublayer(self.outerLayer)

        self.borderLayer.applyShadow(UIControl.State.highlighted)
        self.clockView.layer.addSublayer(self.borderLayer)
        
        self.midLayer.applyShadow(UIControl.State.highlighted)
        self.clockView.layer.addSublayer(self.midLayer)
        
        self.clockView.layer.addSublayer(self.hourLayer)
        self.clockView.layer.insertSublayer(self.minuteLayer, below: self.hourLayer)
        self.clockView.layer.addSublayer(self.secondsLayer)
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            self?.setTime()
        }
    }

    private func setTime() {
        let now = Date()
        let seconds = CGFloat(Calendar.current.component(.second, from: now))
        let minutes = CGFloat(Calendar.current.component(.minute, from: now))
        var hour = CGFloat(Calendar.current.component(.hour, from: now))
        if hour > 12 {
            hour -= 12
        }

        self.hourLayer.transform = CATransform3DMakeRotation(hour / 12 * 2 * .pi, 0.0, 0.0, 1.0)
        self.minuteLayer.transform = CATransform3DMakeRotation(minutes / 60 * 2 * .pi, 0.0, 0.0, 1.0)
        self.secondsLayer.transform = CATransform3DMakeRotation(seconds / 60 * 2 * .pi, 0.0, 0.0, 1.0)
    }
}
