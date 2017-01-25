//
//  CircleViewModel.swift
//  RxSwiftDemos
//
//  Created by Wei Zhang on 1/23/17.
//  Copyright © 2017 Wei Zhang. All rights reserved.
//
//  View model for #2 example -- Observable and Bind

import UIKit
import ChameleonFramework
import RxCocoa
import RxSwift


class CircleViewModel {
    
    // Create one variable, will save data to it and get data from it
    var centerVariable = Variable<CGPoint?>(CGPoint.zero)
    // Create observable that will change the background color
    var backgroundColorObservable: Observable<UIColor>?
    
    init() {
        setup()
    }
    
    func setup() {
        // When we get new center position, emit new background color
        backgroundColorObservable = centerVariable.asObservable()
            .map { newCenter in
                guard let center = newCenter else {
                    return UIColor.flatten(.black)()
                }
                
            }
    }
    
}
