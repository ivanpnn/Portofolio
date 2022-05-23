//
//  ViewController.swift
//  Game-List
//
//  Created by MacBook Noob on 11/08/21.
//

import UIKit

class MainViewController: UIViewController {
    var selectedIndex: Int = 0
    var previousIndex: Int = 0

    var viewControllers = [UIViewController]()
    static let firstVC = GameListViewController()
    static let secondVC = ProfileViewController()
    static let thirdVC = FavoriteViewController()
    
    var tabBarView = UITabBarView()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers.append(MainViewController.firstVC)
        viewControllers.append(MainViewController.secondVC)
        viewControllers.append(MainViewController.thirdVC)
        
        tabBarView.homeButton.isSelected = true
        tabBarView.profileButton.isSelected = false
        tabBarView.favoriteButton.isSelected = false
        
        let vc = viewControllers[0]
        vc.view.frame = UIApplication.shared.windows[0].frame
        vc.didMove(toParent: self)
        self.addChild(vc)
        self.view.addSubview(vc.view)
        
        self.view.bringSubviewToFront(tabBarView)
        
        tabBarView.delegate = self
        view.addSubview(tabBarView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBarView.frame = CGRect(x: 0,
                                  y: view.height() - 100,
                                  width: view.width(),
                                  height: 100)
    }

}

extension MainViewController: UITabBarViewDelegate {
    func didTabBarContentTappedFor(title: String) {
        let previousVC: UIViewController
        var vc: UIViewController
        
        if title == "Home" {
            print("Home")
            selectedIndex = 0
            previousVC = viewControllers[previousIndex]
            
        } else if title == "Profile" {
            print("Profile")
            selectedIndex = 1
            previousVC = viewControllers[previousIndex]
        } else {
            print("Favorite")
            selectedIndex = 2
            previousVC = viewControllers[previousIndex]
        }
        
        vc = viewControllers[selectedIndex]
        previousIndex = selectedIndex
        
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        
        vc.view.frame = UIApplication.shared.windows[0].frame
        vc.didMove(toParent: self)
        self.addChild(vc)
        self.view.addSubview(vc.view)
        
        self.view.bringSubviewToFront(tabBarView)
        
    }
    
}


