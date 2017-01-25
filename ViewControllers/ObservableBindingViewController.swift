//
//  ObservableBindingViewController.swift
//  RxSwiftDemos
//
//  Created by Wei Zhang on 1/23/17.
//  Copyright © 2017 Wei Zhang. All rights reserved.
//

import UIKit

let CircleSize: CGFloat = 50.0

class ObservableBindingViewController: WZViewController {
    
    // properties are strong by default
    weak var circleView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor.white
        
        //1. Circle view
        let circleView = UIView.init(frame: CGRect.zero)
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.layer.cornerRadius = CircleSize/2
        circleView.backgroundColor = UIColor.green
        circleView.center = self.view.center
        self.circleView = circleView
        self.view.addSubview(self.circleView!)
        NSLayoutConstraint.pinWidth(self.circleView!, width: CircleSize)
        NSLayoutConstraint.pinHeight(self.circleView!, height: CircleSize)
        NSLayoutConstraint.pinCenter(self.circleView!, superView: self.view)
        
        //2. Add gesture recognizer
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(circleMoved(_:)))
        self.circleView!.addGestureRecognizer(gestureRecognizer)
        
    }
    
    func circleMoved(_ recognizer: UIPanGestureRecognizer) {
        let location = recognizer.location(in: self.view)
        UIView.animate(withDuration: 0.1) { 
            self.circleView!.center = location
        }
    }
    
}
