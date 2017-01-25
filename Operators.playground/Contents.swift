//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import RxCocoa


var str = "operators"

let sequenceInt = Observable.of(1,2,2,3,4,5,5,6)
let sequenceString = Observable.of("a", "b", "c")
let disposeBag = DisposeBag()






/*
 *  1. transform 变换序列
 */








// 1.1 map
//map 就是用你指定的方法去变换每一个值，
sequenceInt
    .map { 2 * $0 }
    .subscribe {
//        print($0)
    }
    .addDisposableTo(disposeBag)

// 1.2 flatMap, flatMapFirst, flatMapLatest
//将一个序列发射的值转换成序列，然后将他们压平到一个序列。这也类似于 SequenceType 中的 flatMap 。
sequenceInt
    .flatMap { num -> Observable<String> in
//        print("from sequence \(num)")
        return sequenceString
    }
    .subscribe {
//        print($0)
    }
    .addDisposableTo(disposeBag)

// 1.3 scan(x,y in x+y)
//应用一个 accumulator (累加) 的方法遍历一个序列，然后返回累加的结果。此外我们还需要一个初始的累加值。实时上这个操作就类似于 Swift 中的 reduce 。
sequenceInt
    .scan(0) { (rs, cur) -> Int in
        rs + cur
    }
    .subscribe {
//        print($0)
    }
    .addDisposableTo(disposeBag)

// 1.4 reduce
// 和 scan 非常相似，唯一的不同是， reduce 会在序列结束时才发射最终的累加值。就是说，最终只发射一个最终累加值。


// 1.5 buffer
// 在特定的线程，定期定量收集序列发射的值，然后发射这些的值的集合。
// - returns: An observable sequence of buffers.
// - returns: RxSwift.Observable<[Self.E]>

sequenceInt
    .buffer(timeSpan: 4, count: 2, scheduler: MainScheduler.instance)
    .subscribe {
//        print($0)
    }.addDisposableTo(disposeBag)


// 1.6 window
//window 和 buffer 非常类似。唯一的不同就是 window 发射的是序列， buffer 发射一系列值。

//- returns: An observable sequence of windows (instances of `Observable`).

//- returns: RxSwift.Observable<RxSwift.Observable<Self.E>>

sequenceInt
    .window(timeSpan: 2, count: 2, scheduler: MainScheduler.instance)
    .subscribe {
//        print($0)
    }.addDisposableTo(disposeBag)



// 1.7 concat 
//串行的合并多个序列
// Concatenates all inner observable sequences, as long as the previous observable sequence terminated successfully.

// 1.8


SerialDispatchQueueScheduler.init(qos: .userInteractive)
ConcurrentDispatchQueueScheduler.init(qos: DispatchQoS.default)

OperationQueueScheduler.init(operationQueue: OperationQueue.init())

/*
 *  2. filter 过滤序列
 */









// 2.1 filter
// filter 应该是最常用的一种过滤操作了。传入一个返回 bool 的闭包决定是否去掉这个值。
// Filters the elements of an observable sequence based on a predicate.
//可以从这个例子中看到我们过滤掉了所有奇数。 filter 有一个很常见的场景，黑名单，就比如朋友圈，产品狗突然想来一个黑名单功能，这时我们一个 filter 就完成了。

sequenceInt
    .filter { $0 % 2 == 0 }
    .subscribe {
//        print($0)
    }.addDisposableTo(disposeBag)


// 2.2 distinct untill changed
// 阻止发射与上一个重复的值。
//  Returns an observable sequence that contains only distinct contiguous elements according to equality operator.
sequenceInt
    .distinctUntilChanged()
    .subscribe {
//        print($0)
    }.addDisposableTo(disposeBag)

//2.3 take
// 只发射指定数量的值。
// Returns a specified number of contiguous elements from the start of an observable sequence.
sequenceInt
    .take(3)
    .subscribe {
//        print($0)
    }.addDisposableTo(disposeBag)

// 2.4 take last
// 只发射序列结尾指定数量的值。所以 takeLast 会等序列结束才向后发射值.
// Returns a specified number of contiguous elements from the end of an observable sequence.
sequenceInt
    .takeLast(3)
    .subscribe {
//       print($0)
    }.addDisposableTo(disposeBag)

// 2.5  skip
// 忽略指定数量的值。
// Bypasses a specified number of elements in an observable sequence and then returns the remaining elements.
sequenceInt
    .skip(3)
    .subscribe {
//        print($0)
    }.addDisposableTo(disposeBag)


//2.6 debounce / throttle
// 仅在过了一段指定的时间还没发射数据时才发射一个数据，换句话说就是 debounce 会抑制发射过快的值。注意这一操作需要指定一个线程。
// debounce 和 throttle 是同一个东西。
// Ignores elements from an observable sequence which are followed by another element within a specified relative time duration, using the specified scheduler to run throttling timers.
sequenceInt
    .debounce(1, scheduler: MainScheduler.instance)
    .subscribe {
//        print($0)
    }.addDisposableTo(disposeBag)


//2.7 element at
// 使用 elementAt 就只会发射一个值了，也就是指发射序列指定位置的值，比如 elementAt(2) 就是只发射第三个值。
// 注意序列的计算也是从 0 开始的。
// Returns a sequence emitting only item _n_ emitted by an Observable
Observable.of(1, 2, 3, 4, 5, 6)
    .elementAt(2)
    .subscribe {
//        print($0)
    }
    .addDisposableTo(disposeBag)


//2.8 signle
// single 就类似于 take(1) 操作，不同的是 single 可以抛出两种异常： RxError.MoreThanOneElement 和 RxError.NoElements 。当序列发射多于一个值时，就会抛出 RxError.MoreThanOneElement ；当序列没有值发射就结束时， single 会抛出 RxError.NoElements 。
// The single operator is similar to first, but throws a `RxError.NoElements` or `RxError.MoreThanOneElement`
//if the source Observable does not emit exactly one item before successfully completing.
Observable.of(1, 2, 3, 4, 5, 6)
    .single()
    .subscribe {
//        print($0)
    }
    .addDisposableTo(disposeBag)

//2.9 sample
// sample 就是抽样操作，按照 sample 中传入的序列发射情况进行抽样。
// 如果源数据没有再发射值，抽样序列就不发射，也就是说不会重复抽样。
// Samples the source observable sequence using a sampler observable sequence producing sampling ticks.
Observable<Int>.range(start: 1, count: 100)
        .sample(Observable<Int>.range(start: 1, count: 4))
    .subscribe {
//        print($0)
    }.addDisposableTo(disposeBag)

    
//2.10 takeUntil  takeWhile

//takeUntil:
//Returns the elements from the source observable sequence until the other observable sequence produces an element.

//takeWhile: 
// Returns elements from an observable sequence as long as a specified condition is true.


// 2.11 amb
// amb 用来处理发射序列的操作，不同的是， amb 选择先发射值的序列，自此以后都只关注这个先发射序列，抛弃其他所有序列。







/*
 *  3. Combine 组合序列
 */












//3.1 start with 
// 在一个序列前插入一个值。
// Prepends a sequence of values to an observable sequence.
let subscription = Observable.of(4, 5, 6)
    .startWith(3)
    .startWith(2)
    .subscribe {
//        print($0)
}


//3.2 combine latest
// 当两个序列中的任何一个发射了数据时，combineLatest 会结合并整理每个序列发射的最近数据项。
// Merges the specified observable sequences into one observable sequence by using the selector function whenever any of the observable sequences produces an element.

let strOb1 = PublishSubject<String>()
let intOb2 = PublishSubject<Int>()

Observable.combineLatest(strOb1, intOb2) {
        $0 + "\($1)"
    }
    .subscribe {
//        print($0)
    }.addDisposableTo(disposeBag)

strOb1.onNext("A")
intOb2.onNext(1)

strOb1.onNext("B")
intOb2.onNext(2)

//--

//let intOb1 = Observable.just(2)
//let intOb2 = Observable.of(0, 1, 2, 3)
//let intOb3 = Observable.of(0, 1, 2, 3, 4)
//
//_ = Observable.combineLatest(intOb1, intOb2, intOb3) {
//    "\($0) \($1) \($2)"
//    }
//    .subscribe {
//        print($0)
//}



//3.3 Zip
// zip 和 combineLatest 相似，不同的是每当所有序列都发射一个值时， zip 才会发送一个值。它会等待每一个序列发射值，发射次数由最短序列决定。结合的值都是一一对应的
// Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.


//let intOb11 = PublishSubject<String>()
//let intOb21 = PublishSubject<Int>()
//
//Observable.zip(intOb11, intOb21) {
////    "(\($0) \($1))"
//    }
//    .subscribe {
//        print($0)
//    }.addDisposableTo(disposeBag)
//
//intOb11.onNext("A")
//intOb21.onNext(1)
//intOb11.onNext("B")
//intOb11.onNext("C")
//intOb21.onNext(2)


//3.4 merge
//merge 会将多个序列合并成一个序列，序列发射的值按先后顺序合并。要注意的是 merge 操作的是序列，也就是说序列发射序列才可以使用 merge 。
//我们通过 of 操作将 subject1 和 subject2 作为序列的值按顺序发射。这里发射的就是序列，我们才可以调用 merge 这个操作。
//
let subject1 = PublishSubject<Int>()
let subject2 = PublishSubject<Int>()

_ = Observable.of(subject1, subject2)
    .merge()
//    .merge(maxConcurrent: 2)
    .subscribe {
//        print($0)
}

subject1.onNext(20)
subject1.onNext(40)
subject1.onNext(60)
subject2.onNext(1)
subject1.onNext(80)
subject1.onNext(100)
subject2.onNext(1)










