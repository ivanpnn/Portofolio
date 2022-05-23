//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Animation with Pods */
        /* Comment below code if you don't not interest to use Pods*/
        titleLabel.text = K.appName
        
        /* Animation manually without Pods */
        /* Uncomment these below codes if you interest to use manual codes */
        /*
        titleLabel.text = ""
        let title = "⚡️FlashChat"
        var charIndex = 0.0

        for char in title {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.titleLabel.text?.append(char)
            }
            charIndex += 1
        } */

       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.isNavigationBarHidden = false
    }
    

}
