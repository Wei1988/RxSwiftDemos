//
//  SearchCityIIVViewController.swift
//  RxSwiftDemos
//
//  Created by Wei Zhang on 1/29/17.
//  Copyright © 2017 Wei Zhang. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SearchCityIIVViewController: WZViewController {
    
    weak var searchBar: UISearchBar!
    weak var tableView: UITableView!
    var allCities: [String] = ["Beijing", "Shanghai", "Guangzhou", "Shenzhen", "Wuhan", "Beijiaer", "ChongChong", "Chongqing"]
    var shownCities: Variable<[String]> = Variable<[String]>([])
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupSearchBar()
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupSearchBar() {
        // Initialize
        let sb = UISearchBar()
        self.searchBar = sb
        sb.showsCancelButton = true
        // Auto Layout
        sb.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(sb)
        NSLayoutConstraint.pinAllEdges(sb, superView: self.view, shouldPinLeft: true, leftMargin: 0, shouldPinRight: true, rightMargin: 0, shouldPinTop: true, topMargin: 0, shouldPinBottom: false, bottomMargin: 0)
        // Set Observable
        self.searchBar
            .rx.text
            .orEmpty                // convert optional to non-optional, filter nil values
            .filter{ !$0.isEmpty }  // filter empty strings
            .debounce(0.5, scheduler: MainScheduler.instance)  // debounce for 0.5 seconds
            .distinctUntilChanged() // only send distinct values
            .subscribe(onNext: {
                [unowned self] (query) in
                    self.shownCities.value = self.allCities.filter{ $0.lowercased().hasPrefix(query.lowercased()) }
            }).addDisposableTo(disposeBag)
        
        // search bar cancel button clicked control event
        self.searchBar
            .rx
            .cancelButtonClicked
            .subscribe(onNext: {
                [unowned self] in
                    self.shownCities.value = [String]()
                    self.searchBar.resignFirstResponder()
                    self.searchBar.text = ""
            }).addDisposableTo(disposeBag)
        
        self.searchBar
            .rx
            .searchButtonClicked
            .subscribe(onNext: {
                [unowned self] in
                    self.searchBar.resignFirstResponder()
            }).addDisposableTo(disposeBag)
    }
    
    func setupTableView() {
        // Initialize
        let tb = UITableView()
        self.tableView = tb
        tb.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        // Auto Layout
        tb.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tb)
        NSLayoutConstraint.pinAllEdges(tb, superView: self.view, shouldPinLeft: true, leftMargin: 0, shouldPinRight: true, rightMargin: 0, shouldPinTop: false, topMargin: 0, shouldPinBottom: true, bottomMargin: 0)
        NSLayoutConstraint.init(item: tb, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: self.searchBar, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        // Set Observable
        self.shownCities
            .asObservable()
            .bindTo(self.tableView.rx.items) {
                (tableView, row, item) in
                    let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
                    cell.textLabel?.text = "row: \(row) - text: \(item)"
                    return cell
            }.addDisposableTo(disposeBag)
        
    }

    
}
