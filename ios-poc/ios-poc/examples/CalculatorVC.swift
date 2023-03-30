//
//  CalculatorVC.swift
//  ios-poc
//
//  Created by Jerome Bach on 29/03/2023.
//

import Foundation
import UIKit

final class CalculatorVC: UIViewController {
    enum ButtonType: Int {
        case zero
        case one
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
        case comma
        case equal
        case plus
        case minus
        case product
        case divide
        case percent
        case invertSign
        case ac

        var title: String {
            switch self {
            case .zero: return "0"
            case .one: return "1"
            case .two: return "2"
            case .three: return "3"
            case .four: return "4"
            case .five: return "5"
            case .six: return "6"
            case .seven: return "7"
            case .eight: return "8"
            case .nine: return "9"
            case .comma: return "."
            case .equal: return "="
            case .plus: return "+"
            case .minus: return "-"
            case .product: return "x"
            case .divide: return "÷"
            case .percent: return "%"
            case .invertSign: return "±"
            case .ac: return "AC"
            }
        }
        
        static var grid: [[ButtonType]] {
            return [
                [.ac, .invertSign, .percent, .divide],
                [.seven, .eight, .nine, .product],
                [.four, .five, .six, .minus],
                [.one, .two, .three, .plus],
                [.zero, .comma, .equal]
            ]
        }
    }

    let resultLabel: UILabel = {
        var label = NeuLabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(78)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        label.text = "0"
        label.textAlignment = .right
        return label
    }()
    
    var result: Float = 0
    
    lazy var buttonAction: UIAction = UIAction { action in
        guard let button = action.sender as? NeuButton else {
            return
        }
        guard let buttonType = ButtonType(rawValue: button.tag) else {
            return
        }
        
        switch buttonType {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .comma:
            self.resultLabel.text = (self.resultLabel.text ?? "") + buttonType.title
        case .equal:
            break
        case .plus:
            break
        case .minus:
            break
        case .product:
            break
        case .divide:
            break
        case .percent:
            break
        case .invertSign:
            break
        case .ac:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
    }

    private func initUI() {
        self.view.backgroundColor = ThemeManager.currentTheme().bgColor

        let wrap = UIView()
        self.view.addSubview(wrap)
        wrap.constraintToSafe(inset: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        
        wrap.addSubview(self.resultLabel)
        self.resultLabel.topAnchor.constraint(equalTo: wrap.topAnchor).isActive = true
        self.resultLabel.leadingAnchor.constraint(equalTo: wrap.leadingAnchor).isActive = true
        self.resultLabel.trailingAnchor.constraint(equalTo: wrap.trailingAnchor).isActive = true
        let resultLabelHeightConstraint = self.resultLabel.heightAnchor.constraint(equalTo: wrap.heightAnchor, multiplier: 0.2)
        resultLabelHeightConstraint.priority = .defaultLow
        resultLabelHeightConstraint.isActive = true
        
        let mainStack = UIStackView()
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .vertical
        mainStack.distribution = .fillEqually
        mainStack.spacing = 10
        
        wrap.addSubview(mainStack)
        mainStack.topAnchor.constraint(equalTo: self.resultLabel.bottomAnchor).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: wrap.bottomAnchor).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: wrap.leadingAnchor).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: wrap.trailingAnchor).isActive = true
        
        for row in 0..<ButtonType.grid.count {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.distribution = .fill
            rowStack.spacing = 10

            for buttonType in ButtonType.grid[row] {
                let button = NeuButton(frame: .zero)
                button.tag = buttonType.rawValue
                button.setTitle(buttonType.title, for: UIControl.State.normal)
                rowStack.addArrangedSubview(button)
                button.translatesAutoresizingMaskIntoConstraints = false
                let buttonHeightConstraint = button.heightAnchor.constraint(equalTo: button.widthAnchor)
                buttonHeightConstraint.priority = .defaultHigh
                buttonHeightConstraint.isActive = true
                button.addAction(self.buttonAction, for: UIControl.Event.touchUpInside)
            }
            mainStack.addArrangedSubview(rowStack)
        }
    }
}
