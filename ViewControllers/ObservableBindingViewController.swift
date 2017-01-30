//
//  ObservableBindingViewController.swift
//  RxSwiftDemos
//
//  Created by Wei Zhang on 1/23/17.
//  Copyright © 2017 Wei Zhang. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

let CircleSize: CGFloat = 50.0

class ObservableBindingViewController: WZViewController {
    
    // properties are strong by default
    weak var circleView: UIView!
    
    var circleViewModel: CircleViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor.white
        
        //1. Circle view
        let circleView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: CircleSize, height: CircleSize))
//        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.layer.cornerRadius = CircleSize/2
        circleView.backgroundColor = UIColor.green
        circleView.center = self.view.center
        self.circleView = circleView
        self.view.addSubview(self.circleView!)
//        NSLayoutConstraint.pinWidth(self.circleView!, width: CircleSize)
//        NSLayoutConstraint.pinHeight(self.circleView!, height: CircleSize)
//        NSLayoutConstraint.pinCenter(self.circleView!, superView: self.view)
        
        //2. Add gesture recognizer
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(circleMoved(_:)))
        self.circleView!.addGestureRecognizer(gestureRecognizer)
        
        
        //3. Circle view model
        self.circleViewModel = CircleViewModel()
        
        let disposeBag = DisposeBag()
        

        // Bind the center of circleView to centerVariable
        // Note: variable always be used as data source
    
        
        
        self.circleView
            .rx.observe(CGPoint.self, "center")
            .bindTo(circleViewModel.centerVariable)
            .addDisposableTo(disposeBag)
        
        
//
//        
// Subscribe to backgroundObservable to get new colors from the ViewModel.
        self.circleViewModel.backgroundColorObservable
            .subscribe(onNext: { [weak self] backgroundColor in
                UIView.animate(withDuration: 0.1, animations: {
                    print(backgroundColor)
                    self?.circleView!.backgroundColor = UIColor.yellow
                    let viewBackground = UIColor(complementaryFlatColorOf: backgroundColor)
                    if viewBackground != backgroundColor {
                        self?.view.backgroundColor = backgroundColor
                    }
                })
            }).addDisposableTo(disposeBag)
        
        
    }
    
    func circleMoved(_ recognizer: UIPanGestureRecognizer) {
        let location = recognizer.location(in: self.view)
        UIView.animate(withDuration: 0.1) { 
            self.circleView.center = location
        }
    }
    
}
