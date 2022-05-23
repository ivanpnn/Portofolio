//
//  ViewController.swift
//  PRACTICE-PinchGesture
//
//  Created by MacBook Noob on 26/06/21.
//

import UIKit

class ViewController: UIViewController {
    
    let rectangle: UIView = {
        let myRectangle = UIView()
        myRectangle.backgroundColor = .blue
        return myRectangle
    }()
    
    private var size: CGFloat = 300

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(rectangle)
        
        rectangle.frame = CGRect(x: 0, y: 0, width: size, height: size)
        rectangle.center = view.center
        rectangle.layer.masksToBounds = true
        rectangle.layer.cornerRadius = 10
        
        setGesture()
    }
    
    private func setGesture() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinched(_:)))
        rectangle.addGestureRecognizer(pinchGesture)
    }
    
    @objc private func didPinched(_ gesture: UIPinchGestureRecognizer) {
        if gesture.state == .changed {
            rectangle.frame = CGRect(x: 0,
                                     y: 0,
                                     width: size * gesture.scale,
                                     height: size * gesture.scale)
            rectangle.center = view.center
        } else if gesture.state == .ended {
            size = rectangle.frame.width
        }
    }


}

