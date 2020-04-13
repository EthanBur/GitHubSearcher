//
//  MainView.swift
//  T-Mobile_Code_Challenge
//
//  Created by mcs on 4/11/20.
//  Copyright © 2020 MCS. All rights reserved.
//

import UIKit

class MainView: UIView {
    let tableview: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search For Users"
        searchController.hidesNavigationBarDuringPresentation = false
        
        return searchController
    }()
    
    weak var controller: UIViewController?
    var gitUsers: [User] = []
    var gitUserAdditional: [additionalUser] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(MainViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableview.tableHeaderView = searchController.searchBar
        searchController.searchBar.sizeToFit()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        self.controller?.navigationController?.title = "GitHub Searcher"
        self.controller?.navigationItem.searchController = searchController
        self.controller?.navigationItem.hidesSearchBarWhenScrolling = false
        setupViews()
}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(tableview)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableview.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
