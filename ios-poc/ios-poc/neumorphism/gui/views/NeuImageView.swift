//
//  NeuImageView.swift
//  ios-poc
//
//  Created by Jerome Bach on 30/03/2023.
//

import Foundation
import UIKit

class NeuImageView: UIView, UIViewCodingProtocol {
    
    private var neuLayer = NeuLayer()
    private(set) var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    var insetBorderWidth: CGFloat = 8
    var isRounded: Bool = true
    
    // MARK: - UI
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        self.layer.insertSublayer(self.neuLayer, below: self.layer)
        self.neuLayer.applyShadow()

        self.addSubview(self.imageView)
        self.imageView.constraint(self, inset: UIEdgeInsets(top: self.insetBorderWidth, left: self.insetBorderWidth, bottom: self.insetBorderWidth, right: self.insetBorderWidth))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.isRounded ? self.bounds.height / 2 : 0
        self.neuLayer.bounds = self.layer.bounds
        self.neuLayer.frame.origin = .zero
        self.neuLayer.cornerRadius = self.layer.cornerRadius
        self.imageView.layer.cornerRadius = self.isRounded ? self.imageView.bounds.height / 2 : 0
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.imageView.image = UIImage(data: data)
            }
        }
    }
}
