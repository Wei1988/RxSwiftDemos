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
    var backgroundColorObservable: Observable<UIColor>!
    
    init() {
        backgroundColorObservable = centerVariable.asObservable()
            .map { center in
                guard let temp = center else { return UIColor.flatten(.black)() }
                
                let red: CGFloat = ((temp.x + temp.y).truncatingRemainder(dividingBy: 255.0)) / 255.0 // We just manipulate red, but you can do w/e
                let green: CGFloat = 0.0
                let blue: CGFloat = 0.0
                
                return UIColor.flatten(UIColor(red: red, green: green, blue: blue, alpha: 1.0))()
        }
    }
    

}
