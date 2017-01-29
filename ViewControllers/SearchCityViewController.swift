//
//  SearchCityViewController.swift
//  RxSwiftDemos
//
//  Created by Wei Zhang on 1/22/17.
//  Copyright © 2017 Wei Zhang. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SearchCityViewController: WZViewController, UISearchBarDelegate, UITableViewDataSource {
    
    private weak var searchBar: UISearchBar?
    private weak var tableView: UITableView?
    
    var shownCities = [String]() // data source of table view
    let allCities = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Praga"] // Our mocked API data source
    
    // debounce() makes the delay effect on given scheduler, API spamming protection
    // distinceUntilChanged() protect us from the same values
    
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        searchBar!
            .rx.text  // Observable property thanks to RxCocoa
            .orEmpty  // Make it non-optional
            .debounce(0.5, scheduler: MainScheduler.instance) // wait 0.5 for changes
            .distinctUntilChanged() // check if the new value is the same as old
            .filter{ !$0.isEmpty }    // filter for non-empty query
            .subscribe(onNext: {
               [unowned self] query in
                    self.shownCities = self.allCities.filter {$0.hasPrefix(query)}
                    self.tableView?.reloadData()
            }).addDisposableTo(disposeBag)
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor.white
        
        //1. search bar
        let sBar = UISearchBar()
        searchBar = sBar
        searchBar?.delegate = self
        searchBar?.showsCancelButton = true
        searchBar?.placeholder = "search cities"
        
        searchBar?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchBar!)
        NSLayoutConstraint.pinAllEdges(searchBar!, superView: self.view, shouldPinLeft: true, leftMargin: 0, shouldPinRight: true, rightMargin: 0, shouldPinTop: true, topMargin: 22, shouldPinBottom: false, bottomMargin: 0)
        
        //2. table view
        let cityTableView = UITableView()
        tableView = cityTableView
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        tableView?.dataSource = self
        tableView?.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView!)
        NSLayoutConstraint.pinAllEdges(tableView!, superView: self.view, shouldPinLeft: true, leftMargin: 0, shouldPinRight: true, rightMargin: 0, shouldPinTop: false, topMargin: 0, shouldPinBottom: true, bottomMargin: 0)
        NSLayoutConstraint.init(item: tableView!, attribute: .top, relatedBy: .equal, toItem: searchBar!, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        
    }
    
    // MARK: Search bar delegate methods
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("search text is \(searchBar.text)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    // MARK: Table view data source methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shownCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = shownCities[indexPath.row]
        return cell
    }
    
    
    
    
}
