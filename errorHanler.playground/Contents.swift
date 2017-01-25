//: Playground - noun: a place where people can play

import UIKit
import RxSwift

var str = "Error Handler"
let disposeBag = DisposeBag()
let error = NSError.init(domain: "System", code: 0, userInfo: nil)
// 1. retry
// 先来看看 retry ，可能这个操作会比较常用，一般用在网络请求失败时，再去进行请求。
//retry 就是失败了再尝试，重新订阅一次序列
//Repeats the source observable sequence until it successfully terminates.

var count = 1
let sequence = Observable<Int>.create { observer -> Disposable in
    
    observer.onNext(0)
    observer.onNext(1)
    observer.onNext(2)
    if count < 2 {
        observer.onError(error)
        count += 1
    }
    observer.onNext(3)
    observer.onNext(4)
    observer.onCompleted()
    return Disposables.create()
}

sequence.retry()
    .subscribe {
//        print($0)
    }.addDisposableTo(disposeBag)

//2. catch Error
//当出现 Error 时，用一个新的序列替换。
//Continues an observable sequence that is terminated by an error with the observable sequence produced by the handler.
let sequenceFail = PublishSubject<Int>()
let sequenceBackup = Observable.of(10, 20, 30, 40)

sequenceFail
    .catchError { error in
        return sequenceBackup
    }.subscribe {
//        print($0)
    }.addDisposableTo(disposeBag)

sequenceFail.onNext(1)
sequenceFail.onNext(2)
sequenceFail.onError(error)
sequenceFail.onNext(3)





