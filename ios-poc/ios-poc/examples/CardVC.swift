//
//  CardVC.swift
//  ios-poc
//
//  Created by Jerome Bach on 01/04/2023.
//

import Foundation
import UIKit

final class CardVC: UIViewController {

    lazy var heart: NeuCard = {
        return self.createCard("suit.heart.fill")
    }()
    lazy var club: NeuCard = {
        return self.createCard("suit.club.fill")
    }()
    lazy var diamond: NeuCard = {
        return self.createCard("suit.diamond.fill")
    }()
    lazy var spade: NeuCard = {
        return self.createCard("suit.spade.fill")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    private func initUI() {
        self.view.backgroundColor = ThemeManager.currentTheme().bgColor
        
        let space: CGFloat = 20
        
        let view = UIView()
        self.view.addSubview(view)
        view.constraintToSafe(inset: UIEdgeInsets(top: space, left: space, bottom: space, right: space))

        let topStack = UIStackView(arrangedSubviews: [self.heart, self.club])
        topStack.axis = .horizontal
        topStack.distribution = .fillEqually
        topStack.spacing = space
        view.addSubview(topStack)
        topStack.constraintToTop()
        
        let botStack = UIStackView(arrangedSubviews: [self.diamond, self.spade])
        botStack.axis = .horizontal
        botStack.distribution = .fillEqually
        botStack.spacing = space
        view.addSubview(botStack)
        botStack.constraintToBottom()
        botStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: space).isActive = true
        botStack.heightAnchor.constraint(equalTo: topStack.heightAnchor, constant: space).isActive = true
    }

    private func createCard(_ imageName: String) -> NeuCard {
        let card = NeuCard()
        let image = UIImage(systemName: imageName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        card.addSubview(imageView)
        imageView.constraint()
        
        let hiddenImage = UIImage(systemName: "\(Int.random(in: 0..<11)).circle.fill")
        let hiddenImageView = UIImageView(image: hiddenImage)
        hiddenImageView.contentMode = .scaleAspectFit
        hiddenImageView.isHidden = true
        card.addSubview(hiddenImageView)
        hiddenImageView.constraint()

        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        card.addGestureRecognizer(tap)
        return card
    }

    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        guard let card = sender.view as? NeuCard else {
            return
        }
        /*UIView.animate(withDuration: 1, delay: 0) {
            card.transform3D = CATransform3DRotate(card.transform3D, .pi, 0, 1, 0)
        }*/
        let flipped = card.subviews.first?.isHidden == false
        guard let fromView = flipped ? card.subviews.first : card.subviews[1] else {
            return
        }
        guard let toView = flipped ? card.subviews[1] : card.subviews.first else {
            return
        }
        let flipDirection: UIView.AnimationOptions = flipped ? .transitionFlipFromRight : .transitionFlipFromLeft
        let options: UIView.AnimationOptions = [flipDirection, .showHideTransitionViews]
        UIView.transition(from: fromView, to: toView, duration: 0.6, options: options)
    }
}
