//
//  SplashView.swift
//  RxSwiftDemos
//
//  Created by Wei Zhang on 1/15/17.
//  Copyright © 2017 Wei Zhang. All rights reserved.
//

import UIKit

class SplashView: UIView {
    
    // load spinner
    var loadSpinner: UIActivityIndicatorView?
    
    // initializers
    init() {
        super.init(frame:CGRect.zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // set up view
    func setupView() {
        self.backgroundColor = UIColor.white
        loadSpinner = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        loadSpinner!.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loadSpinner!)
        NSLayoutConstraint.pinCenter(loadSpinner!, superView: self)
    }
    
    func startAnimation() {
        loadSpinner!.startAnimating()
    }
    
    func stopAnimation() {
        loadSpinner!.stopAnimating()
    }
    
}
