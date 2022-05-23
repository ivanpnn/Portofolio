//
//  SecondViewController.swift
//  Game-List
//
//  Created by MacBook Noob on 11/08/21.
//

import UIKit

class ProfileViewController: UIViewController {
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "photo_profile")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
        return view
    }()
    
    var userName: UILabel = {
        let label = UILabel()
        label.text = "Ivan Prasetyo Nugroho"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.font = UIFont(name: "DIN Condensed", size: 40)
        return label
    }()
    
    var aboutMeTitle: UILabel = {
        let label = UILabel()
        label.text = "About me"
        label.font = UIFont(name: "Futura Bold", size: 24)
        label.textColor = .white
        return label
    }()
    
    var aboutMeContent: UILabel = {
        let label = UILabel()
        label.text = "Hello, I'm Ivan. Currently, I'm working as engineer in a multi-national company in Bekasi Regency. I was graduated from Diploma degree and now I'm on my way continuing my degree to Bachelor of Eletronics Engineering. I like K-pop and K-Drama."
        label.font = UIFont(name: "Gill Sans", size: 16)
        label.textColor = .white
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.13, alpha: 1.00)
        view.addSubview(profileImageView)
        view.addSubview(aboutMeTitle)
        view.addSubview(aboutMeContent)
        
        profileImageView.addSubview(transparentView)
        profileImageView.addSubview(userName)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var imageWidth: CGFloat = 0
        var imageHeight: CGFloat = 0
        var imageAspectRatio: CGFloat = 0
        
        if profileImageView.image != nil {
            imageWidth = profileImageView.image!.size.width
            imageHeight = profileImageView.image!.size.height
            imageAspectRatio = imageWidth / imageHeight
        }
        
        
        profileImageView.frame = CGRect(x: 0,
                                        y: view.safeAreaInsets.top,
                                        width: view.width(),
                                        height: view.width() / imageAspectRatio)
        
        userName.frame = CGRect(x: 0,
                                y: profileImageView.frame.size.height - userName.labelFontSize().height,
                                width: view.width(),
                                height: userName.labelFontSize().height)
        
        transparentView.frame = CGRect(x: 0,
                                       y: userName.top() - 5,
                                       width: profileImageView.frame.size.width,
                                       height: userName.frame.size.height + 5)
        
        aboutMeTitle.frame = CGRect(x: 5,
                                    y: profileImageView.bottom() + 5,
                                    width: aboutMeTitle.labelFontSize().width,
                                    height: aboutMeTitle.labelFontSize().height)
        
        aboutMeContent.frame = CGRect(x: 10,
                                      y: aboutMeTitle.bottom() + 1,
                                      width: view.width() - 30,
                                      height: aboutMeContent.labelFontSize().height)
        aboutMeContent.sizeToFit()
    }
}
