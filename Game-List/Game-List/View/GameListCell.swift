//
//  GameListCell.swift
//  Game-List
//
//  Created by MacBook Noob on 22/08/21.
//

import UIKit
import SkeletonView

class GameListCell: UITableViewCell {
    @IBOutlet var gameImage: UIImageView!
    @IBOutlet var gameNameLbl: UILabel!
    @IBOutlet var releasedDateLbl: UILabel!
    @IBOutlet var ratingLbl: UILabel!
    @IBOutlet var view: UIView!
    @IBOutlet var calendarImage: UIImageView!
    @IBOutlet var starImage: UIImageView!
    
    var skeletonImage = UIImageView()
    var skeletonView1 = UIView()
    var skeletonView2 = UIView()
    var skeletonView3 = UIView()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        view.addSubview(skeletonImage)
        view.addSubview(skeletonView1)
        view.addSubview(skeletonView2)
        view.addSubview(skeletonView3)
        
        skeletonImage.isSkeletonable = true
        skeletonView1.isSkeletonable = true
        skeletonView2.isSkeletonable = true
        skeletonView3.isSkeletonable = true
        
        skeletonImage.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.16, alpha: 0.5)
        skeletonView1.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.16, alpha: 0.5)
        skeletonView2.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.16, alpha: 0.5)
        skeletonView3.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.16, alpha: 0.5)

        skeletonImage.frame = CGRect(x: 10,
                                     y: view.height()/2 - 50,
                                     width: 100,
                                     height: 100)
        skeletonImage.layer.cornerRadius = 10
        skeletonImage.layer.masksToBounds = true
        
        skeletonView1.frame = CGRect(x: skeletonImage.right() + 10,
                                     y: skeletonImage.top(),
                                     width: view.width() - skeletonImage.width() - 60,
                                     height: 25)
        skeletonView1.layer.cornerRadius = 10
        skeletonView1.layer.masksToBounds = true
        
        skeletonView2.frame = CGRect(x: skeletonImage.right() + 10,
                                     y: skeletonView1.bottom() + 10,
                                     width: view.width() - skeletonImage.width() - 60,
                                     height: 25)
        skeletonView2.layer.cornerRadius = 10
        skeletonView2.layer.masksToBounds = true
        
        skeletonView3.frame = CGRect(x: skeletonImage.right() + 10,
                                     y: skeletonView2.bottom() + 10,
                                     width: view.width() - skeletonImage.width() - 80,
                                     height: 25)
        skeletonView3.layer.cornerRadius = 10
        skeletonView3.layer.masksToBounds = true
        
        
        contentView.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.13, alpha: 1.00)
        view.backgroundColor = UIColor(red: 0.20, green: 0.20, blue: 0.25, alpha: 1.00)
        view.layer.cornerRadius = 20
        
        gameNameLbl.adjustsFontSizeToFitWidth = true
        gameNameLbl.textColor = .white
        releasedDateLbl.textColor = .white
        ratingLbl.textColor = .white
    }
    
    func showAnimation() {
        skeletonImage.isHidden = false
        skeletonView1.isHidden = false
        skeletonView2.isHidden = false
        skeletonView3.isHidden = false
        calendarImage.isHidden = true
        starImage.isHidden = true
        skeletonImage.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: UIColor(red: 0.13, green: 0.13, blue: 0.16, alpha: 0.5), secondaryColor: UIColor(red: 0.2, green: 0.2, blue: 0.25, alpha: 0.7)), animation: .none, transition: .crossDissolve(0.25))
        skeletonView1.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: UIColor(red: 0.13, green: 0.13, blue: 0.16, alpha: 0.5), secondaryColor: UIColor(red: 0.2, green: 0.2, blue: 0.25, alpha: 0.7)), animation: .none, transition: .crossDissolve(0.25))
        skeletonView2.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: UIColor(red: 0.13, green: 0.13, blue: 0.16, alpha: 0.5), secondaryColor: UIColor(red: 0.2, green: 0.2, blue: 0.25, alpha: 0.7)), animation: .none, transition: .crossDissolve(0.25))
        skeletonView3.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: UIColor(red: 0.13, green: 0.13, blue: 0.16, alpha: 0.5), secondaryColor: UIColor(red: 0.2, green: 0.2, blue: 0.25, alpha: 0.7)), animation: .none, transition: .crossDissolve(0.25))
    }
    
    func hideAnimation() {
        skeletonImage.hideSkeleton()
        skeletonView1.hideSkeleton()
        skeletonView2.hideSkeleton()
        skeletonView3.hideSkeleton()
        
        skeletonImage.isHidden = true
        skeletonView1.isHidden = true
        skeletonView2.isHidden = true
        skeletonView3.isHidden = true
        calendarImage.isHidden = false
        starImage.isHidden = false
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "GameListCell", bundle: nil)
    }
    
}
