//
//  TrigoCircleVC.swift
//  ios-poc
//
//  Created by Jerome Bach on 26/03/2023.
//

import UIKit

final class TrigoCircleVC: UIViewController, UIActionSheetDelegate {
    enum Angle {
        case start
        case end

        var title: String {
            switch self {
            case .start: return "Start Angle"
            case .end: return "End Angle"
            }
        }
    }

    private let angles: [String:CGFloat] = [
        "0": 0,
        "PI / 4": .pi / 4,
        "PI / 2": .pi / 2,
        "3 PI / 4": .pi * 3 / 4,
        "PI": .pi,
        "5 PI / 4": .pi * 5 / 4,
        "3 PI / 2": .pi * 3 / 2,
        "7 PI / 4": .pi * 7 / 4
    ]
    
    private var startAngle: CGFloat = 0 {
        didSet {
            self.updateCircle()
        }
    }
    private var endAngle: CGFloat = .pi * 7 / 4 {
        didSet {
            self.updateCircle()
        }
    }
    private var clockwise: Bool = true {
        didSet {
            self.updateCircle()
        }
    }
    
    private let startAngleButton = NeuButton(frame: CGRect.zero)
    private let endAngleButton = NeuButton(frame: CGRect.zero)

    private let circleView = UIView()
    private let circleViewLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.initUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.updateCircle()
    }

    private func initUI() {
        self.view.backgroundColor = ThemeManager.currentTheme().bgColor

        // labels
        let labelsStackView = UIStackView()
        labelsStackView.alignment = .center
        labelsStackView.axis = NSLayoutConstraint.Axis.horizontal
        labelsStackView.distribution = .fillEqually
        labelsStackView.spacing = 8
        labelsStackView.constraint(size: CGSize(width: CGFloat.nan, height: 44))
        self.view.addSubview(labelsStackView)
        labelsStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        labelsStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 6).isActive = true
        labelsStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -6).isActive = true

        labelsStackView.addArrangedSubview({
           let label = NeuLabel()
            label.text = Angle.start.title
            label.textAlignment = .center
            return label
        }())
        labelsStackView.addArrangedSubview({
           let label = NeuLabel()
            label.text = Angle.end.title
            label.textAlignment = .center
            return label
        }())
        labelsStackView.addArrangedSubview({
           let label = NeuLabel()
            label.text = "Clockwise"
            label.textAlignment = .center
            return label
        }())

        // buttons
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.constraint(size: CGSize(width: CGFloat.nan, height: 44))
        self.view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: 6).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 6).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -6).isActive = true

        startAngleButton.setTitle(self.angles.filter({ (key, angle) in
            return angle == self.startAngle
        }).first?.key, for: UIControl.State.normal)
        startAngleButton.constraint(size: CGSize(width: CGFloat.nan, height: 44))
        startAngleButton.addAction(UIAction(handler: { _ in
            self.showAngleActionSheet(Angle.start)
        }), for: UIControl.Event.touchUpInside)
        stackView.addArrangedSubview(startAngleButton)
        
        endAngleButton.setTitle(self.angles.filter({ (key, angle) in
            return angle == self.endAngle
        }).first?.key, for: UIControl.State.normal)
        endAngleButton.constraint(size: CGSize(width: CGFloat.nan, height: 44))
        endAngleButton.addAction(UIAction(handler: { _ in
            self.showAngleActionSheet(Angle.end)
        }), for: UIControl.Event.touchUpInside)
        stackView.addArrangedSubview(endAngleButton)

        let aSwitch = NeuSwitch(frame: CGRect.zero)
        aSwitch.cornerRadius = 22
        aSwitch.isOn = self.clockwise
        aSwitch.constraint(size: CGSize(width: CGFloat.nan, height: 44))
        aSwitch.addAction(UIAction(handler: { _ in
            self.clockwise = aSwitch.isOn
        }), for: UIControl.Event.valueChanged)
        stackView.addArrangedSubview(aSwitch)

        self.circleView.backgroundColor = .purple
        self.view.addSubview(self.circleView)
        self.circleView.translatesAutoresizingMaskIntoConstraints = false
        self.circleView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 6).isActive = true
        self.circleView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.circleView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.circleView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true

        self.circleView.layer.addSublayer(self.circleViewLayer)
        self.circleViewLayer.fillColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
    }

    private func showAngleActionSheet(_ kind: Angle) {
        let sheet = UIAlertController(title: title, message: nil, preferredStyle: UIAlertController.Style.actionSheet)

        for (key, angle) in self.angles {
            sheet.addAction(UIAlertAction(title: key, style: UIAlertAction.Style.default, handler: { _ in
                switch kind {
                case .start:
                    self.startAngle = angle
                    self.startAngleButton.setTitle(key, for: UIControl.State.normal)
                case .end:
                    self.endAngle = angle
                    self.endAngleButton.setTitle(key, for: UIControl.State.normal)
                }
            }))
        }
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive))
        
        self.present(sheet, animated: true)
    }

    private func updateCircle() {
        self.circleViewLayer.bounds = self.circleView.bounds
        self.circleViewLayer.frame.origin = .zero

        let center = CGPoint(x: self.circleViewLayer.bounds.midX, y: self.circleViewLayer.bounds.midY)
        let radius = min(center.x, center.y) - 6

        //self.circleViewLayer.position = CGPoint(x: self.circleViewLayer.bounds.midX - radius, y: self.circleViewLayer.bounds.midY - radius)

        let path = UIBezierPath()
        path.move(to: center)
        path.addArc(withCenter: center, radius: radius, startAngle: self.startAngle, endAngle: self.endAngle, clockwise: self.clockwise)
        path.close()

        self.circleViewLayer.path = path.cgPath
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
