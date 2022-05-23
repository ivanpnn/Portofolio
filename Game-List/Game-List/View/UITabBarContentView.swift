//
//  UITabBarContentView.swift
//  Game-List
//
//  Created by MacBook Noob on 11/08/21.
//

import UIKit

protocol UITabBarContentViewDelegate {
    func didTappedUITaBarButtonFor(labelText: String)
}

class UITabBarContentView: UIView {
    var delegate: UITabBarContentViewDelegate?
    var isSelected: Bool {
        get {
            return true
        }
        set {
            if newValue {
                imageView.tintColor = UIColor(red: 0.88, green: 0.42, blue: 0.16, alpha: 1.00)
                label.textColor = UIColor(red: 0.88, green: 0.42, blue: 0.16, alpha: 1.00)
            } else {
                imageView.tintColor = .lightGray
                label.textColor = .lightGray
            }
        }
    }
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let labelText: String
    let image: UIImage

    init(frame: CGRect, labelText: String, image: UIImage) {
        self.labelText = labelText
        self.image = image
        super.init(frame: frame)
        
        label.text = labelText
        imageView.image = image
        
        self.backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.18, alpha: 1.00)

        self.addSubview(imageView)
        self.addSubview(label)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapButton)))
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    @objc private func didTapButton() {
        self.delegate?.didTappedUITaBarButtonFor(labelText: labelText)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundCorners(corners: [.topLeft, .topRight], radius: 40)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UITabBarContentView {
    public func enableGesture(_ isEnabled: Bool) {
        for gesture in self.gestureRecognizers! {
            gesture.isEnabled = isEnabled
        }
    }
}
