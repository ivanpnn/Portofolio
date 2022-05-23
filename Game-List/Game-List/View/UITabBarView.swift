//
//  UITabBarView.swift
//  Game-List
//
//  Created by MacBook Noob on 11/08/21.
//

import UIKit

protocol UITabBarViewDelegate {
    func didTabBarContentTappedFor(title: String)
}

class UITabBarView: UIView {
    var delegate: UITabBarViewDelegate?
    
    let homeLabel = "Home"
    let profileLabel = "Profile"
    let favoriteLabel = "Favorite"
    
    var homeButton  = UITabBarContentView(frame: .zero, labelText: "Home", image: UIImage(systemName: "house")!)
    var profileButton  = UITabBarContentView(frame: .zero, labelText: "Profile", image: UIImage(systemName: "person")!)
    var favoriteButton  = UITabBarContentView(frame: .zero, labelText: "Favorite", image: UIImage(systemName: "star.fill")!)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.18, alpha: 1.00)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        homeButton.delegate = self
        profileButton.delegate = self
        favoriteButton.delegate = self
        
        for gesture in homeButton.gestureRecognizers! {
            gesture.isEnabled = false
        }

        self.addSubview(homeButton)
        self.addSubview(profileButton)
        self.addSubview(favoriteButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        favoriteButton.frame = CGRect(x: 0,
                                  y: 0,
                                  width: self.width()/3,
                                  height: self.height())
        homeButton.frame = CGRect(x: favoriteButton.right(),
                                     y: 0,
                                     width: self.width()/3,
                                     height: self.height())
        profileButton.frame = CGRect(x: homeButton.right(),
                                      y: 0,
                                      width: self.width()/3,
                                      height: self.height())
        
        self.roundCorners(corners: [.topLeft, .topRight], radius: 40)
    }
    
}

extension UITabBarView: UITabBarContentViewDelegate {
    func didTappedUITaBarButtonFor(labelText: String) {
        if labelText == "Home" {
            homeButton.isSelected = true
            homeButton.enableGesture(false)
            
            profileButton.isSelected = false
            profileButton.enableGesture(true)
            
            favoriteButton.isSelected = false
            favoriteButton.enableGesture(true)
            
            delegate?.didTabBarContentTappedFor(title: homeLabel)
        } else if labelText == "Profile" {
            homeButton.isSelected = false
            homeButton.enableGesture(true)

            profileButton.isSelected = true
            profileButton.enableGesture(false)

            favoriteButton.isSelected = false
            favoriteButton.enableGesture(true)
            
            delegate?.didTabBarContentTappedFor(title: profileLabel)
        } else {
            homeButton.isSelected = false
            homeButton.enableGesture(true)
            
            profileButton.isSelected = false
            profileButton.enableGesture(true)
            
            favoriteButton.isSelected = true
            favoriteButton.enableGesture(false)

            delegate?.didTabBarContentTappedFor(title: favoriteLabel)
        }
    }
}
