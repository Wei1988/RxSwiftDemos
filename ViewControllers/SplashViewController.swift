//
//  SplashViewController.swift
//  RxSwiftDemos
//
//  Created by Wei Zhang on 1/21/17.
//  Copyright © 2017 Wei Zhang. All rights reserved.
//

import UIKit

class SplashViewController: WZViewController {
    
    var splashView: SplashView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // set up view
    func setupView() {
        splashView = SplashView()
        splashView!.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(splashView!)
        NSLayoutConstraint.pinAllEdges(splashView!, superView: self.view, shouldPinLeft: true, leftMargin: 0, shouldPinRight: true, rightMargin: 0, shouldPinTop: true, topMargin: 0, shouldPinBottom: true, bottomMargin: 0)
        startAnimating()
    }
    
    func startAnimating() {
        splashView!.startAnimation()
    }
    
    func stopAnimating() {
        splashView!.stopAnimation()
    }
    
}
