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
    
    var circleView: UIView!
    fileprivate var circleViewModel: CircleViewModel!
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
//        self.view.backgroundColor = UIColor.white
        
        //1. Circle view
        circleView = UIView(frame: CGRect(origin: view.center, size: CGSize(width: CircleSize, height: CircleSize)))
//        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.layer.cornerRadius = CircleSize/2
        circleView.backgroundColor = UIColor.green
        circleView.center = self.view.center
        self.view.addSubview(self.circleView!)
        
        
        self.circleViewModel = CircleViewModel()
        circleView
            .rx.observe(CGPoint.self, "center")
            .bindTo(circleViewModel.centerVariable)
            .addDisposableTo(disposeBag)
        
        // Subscribe to backgroundObservable to get new colors from the ViewModel.
        self.circleViewModel.backgroundColorObservable
            .subscribe(onNext: { [weak self] backgroundColor in
                UIView.animate(withDuration: 0.1, animations: {
                    self?.circleView!.backgroundColor = UIColor.yellow
                    let viewBackground = UIColor(complementaryFlatColorOf: backgroundColor)
                    if viewBackground != backgroundColor {
                        self?.view.backgroundColor = backgroundColor
                    }
                })
            }).addDisposableTo(disposeBag)
        
        
//        NSLayoutConstraint.pinWidth(self.circleView!, width: CircleSize)
//        NSLayoutConstraint.pinHeight(self.circleView!, height: CircleSize)
//        NSLayoutConstraint.pinCenter(self.circleView!, superView: self.view)
        
        //2. Add gesture recognizer
        // NOTE: observation(BindTo should always come before adding center changes)
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(circleMoved(_:)))
        self.circleView.addGestureRecognizer(gestureRecognizer)

    }
    
    func circleMoved(_ recognizer: UIPanGestureRecognizer) {
        let location = recognizer.location(in: self.view)
        UIView.animate(withDuration: 0.1) { 
            self.circleView.center = location
        }
    }
    
}
