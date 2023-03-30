//
//  MusicPlayerVC.swift
//  ios-poc
//
//  Created by Jerome Bach on 29/03/2023.
//

import Foundation
import UIKit

final class MusicPlayerVC: UIViewController {

    lazy var backButton: NeuButton = {
        let button = NeuButton(frame: .zero)
        button.setImage(UIImage(systemName: "arrow.backward"), for: UIControl.State.normal)
        button.layer.cornerRadius = 22
        button.constraint(size: CGSize(width: 44, height: 44))
        button.addAction(UIAction(handler: { [weak self] action in
            self?.navigationController?.popViewController(animated: true)
        }), for: UIControl.Event.touchUpInside)
        NeuLayer.applyDarkShadow(button.layer)
        return button
    }()
    let statusLabel: NeuLabel = {
        let label = NeuLabel(frame: .zero)
        label.text = "PLAYING NOW"
        label.textAlignment = .center
        return label
    }()
    let rightButton: NeuButton = {
        let button = NeuButton(frame: .zero)
        button.setImage(UIImage(systemName: "power"), for: UIControl.State.normal)
        button.layer.cornerRadius = 22
        button.constraint(size: CGSize(width: 44, height: 44))
        NeuLayer.applyDarkShadow(button.layer)
        return button
    }()

    let songImage: NeuImageView = {
        let image = NeuImageView(frame: .zero)
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.navigationController?.navigationBar.isHidden = true
        self.initUI()
    }

    deinit {
        //self.navigationController?.navigationBar.isHidden = false
    }

    private func initUI() {
        self.view.backgroundColor = ThemeManager.currentTheme().bgColor
        
        let wrap = UIView()
        self.view.addSubview(wrap)
        wrap.constraintToSafe(inset: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))

        let navBar = UIStackView(arrangedSubviews: [
            self.backButton,
            self.statusLabel,
            self.rightButton
        ])
        navBar.axis = .horizontal
        navBar.distribution = .fill
        wrap.addSubview(navBar)
        navBar.constraint(size: CGSize(width: CGFloat.infinity, height: 44))
        navBar.topAnchor.constraint(equalTo: wrap.topAnchor).isActive = true
        navBar.leadingAnchor.constraint(equalTo: wrap.leadingAnchor).isActive = true
        navBar.trailingAnchor.constraint(equalTo: wrap.trailingAnchor).isActive = true

        wrap.addSubview(self.songImage)
        self.songImage.translatesAutoresizingMaskIntoConstraints = false
        self.songImage.heightAnchor.constraint(equalTo: self.songImage.widthAnchor, multiplier: 1).isActive = true
        self.songImage.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 20).isActive = true
        self.songImage.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: 20).isActive = true
        self.songImage.trailingAnchor.constraint(equalTo: wrap.trailingAnchor, constant: -20).isActive = true
        if let url = URL(string: "https://picsum.photos/300/300") {
            self.songImage.downloadImage(from: url)
        }
        NeuLayer.applyDarkShadow(self.songImage.layer, radius: 20)
        
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        wrap.addSubview(stack)
        stack.constraintToBottom(inset: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        stack.topAnchor.constraint(equalTo: self.songImage.bottomAnchor, constant: 20).isActive = true

        let infoView = UIView(frame: .zero)
        stack.addArrangedSubview(infoView)

        let songTitle = NeuLabel(frame: .zero)
        songTitle.text = "Song title"
        songTitle.textAlignment = .center
        songTitle.font = songTitle.font.withSize(24)
        infoView.addSubview(songTitle)
        songTitle.constraintToTop()
        
        let singerName = NeuLabel(frame: .zero)
        singerName.text = "Artist"
        singerName.textAlignment = .center
        singerName.font = singerName.font.withSize(16)
        infoView.addSubview(singerName)
        singerName.constraintToBottom()
        singerName.topAnchor.constraint(equalTo: songTitle.bottomAnchor).isActive = true
        
        let sliderView = UIView(frame: .zero)
        stack.addArrangedSubview(sliderView)

        let slider = NeuSlider(frame: .zero)
        slider.layer.cornerRadius = 12
        slider.constraint(size: CGSize(width: 280, height: 24))
        sliderView.addSubview(slider)
        slider.constraint()

        let controlsView = UIView(frame: .zero)
        controlsView.constraint(size: CGSize(width: CGFloat.nan, height: 64))
        stack.addArrangedSubview(controlsView)
        let buttonStack = UIStackView()
        buttonStack.alignment = .center
        buttonStack.axis = .horizontal
        buttonStack.distribution = .equalCentering
        buttonStack.spacing = 24
        controlsView.addSubview(buttonStack)
        buttonStack.constraint()
        let button4 = NeuButtonRounded(frame: .zero)
        button4.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        button4.constraint(size: CGSize(width: 64, height: 64))
        buttonStack.addArrangedSubview(button4)
        let button6 = NeuButtonRounded(frame: .zero)
        button6.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button6.constraint(size: CGSize(width: 64, height: 64))
        buttonStack.addArrangedSubview(button6)
        let button7 = NeuButtonRounded(frame: .zero)
        button7.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        button7.constraint(size: CGSize(width: 64, height: 64))
        buttonStack.addArrangedSubview(button7)
    }
}
