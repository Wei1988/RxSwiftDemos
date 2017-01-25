//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import RxCocoa

// chap 1  Create Observable

// 1. create
let myJust = {
    (singleElement: Int) -> Observable<Int> in
    return Observable.create {
        observer -> Disposable in
            print("emitting")
            observer.onNext(singleElement)
            observer.onCompleted()
        return Disposables.create {
            print("Disposed")
        }
    }
}

//myJust(39).subscribe { (event) in
//    print(event)
//}

//2. defer
let deferredSequence: Observable<Int> = Observable.deferred {
        print("creating")
        return Observable.create { (observer) -> Disposable in
            print("emitting")
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
            return Disposables.create()
        }
}

//deferredSequence.subscribe {
//    event in
//        print(event)
//}

//3. interval
let intervalSquence = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//intervalSquence.subscribe {
//    event in
//        print(event)
//}

//4. range 
let rangeSquence = Observable<Int>.range(start: 1, count: 10)
//rangeSquence.subscribe {
//    event in
//        print(event)
//}

//5. timer
let timerSquence = Observable<Int>.timer(1, scheduler: MainScheduler.instance)

//timerSquence.subscribe {
//    event in
//        print(event)
//}


