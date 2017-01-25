//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import RxCocoa

var str = "examples of subject in RxSwift"

let disposeBag = DisposeBag()

// 1. publish subject
//当有观察者订阅 PublishSubject 时，PublishSubject 会发射订阅之后的数据给这个观察者。
//let subject = PublishSubject<String>()

// 2. replay subject
//和 PushblishSubject 不同，不论观察者什么时候订阅， ReplaySubject 都会发射完整的数据给观察者。
//let subject = ReplaySubject<String>.create(bufferSize: 1)

// 3. beahavior subject
//当一个观察者订阅一个 BehaviorSubject ，它会发送原序列最近的那个值（如果原序列还有没发射值那就用一个默认值代替），之后继续发射原序列的值。
let subject = BehaviorSubject(value:"z")

subject.subscribe {
    event in
//        print("subscription 1, event: \(event)")
}
subject.onNext("a")
subject.onNext("b")

subject.subscribe {
    event in
//        print("subscription 2, event: \(event)")
}
subject.onNext("c")
subject.onNext("d")

// 4. variable
// Variable 是 BehaviorSubject 的一个封装。相比 BehaviorSubject ，它不会因为错误终止也不会正常终止，是一个无限序列。
//Variable 很适合做数据源，比如作为一个 UITableView 的数据源，我们可以在这里保留一个完整的 Array 数据，每一个订阅者都可以获得这个 Array 。
let variable = Variable("z")
variable.asObservable().subscribe {
    event in
        print("subscription 1, event: \(event)")
}.addDisposableTo(disposeBag)
variable.value = "a"
variable.value = "b"
variable.asObservable().subscribe {
    event in
        print("subscription 2, event: \(event)")
}.addDisposableTo(disposeBag)
variable.value = "c"
variable.value = "d"

