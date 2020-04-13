//
//  GitUserView.swift
//  T-Mobile_Code_Challenge
//
//  Created by mcs on 4/11/20.
//  Copyright © 2020 MCS. All rights reserved.
//

import UIKit

class GitUserView: UIView {
    let tableview: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    weak var controller: UIViewController?
    var gitUserRepos: [UserRepo] = []
    var filteredRepos: [String] = []
    var userName = ""
//    var filteredUserImageUrl: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        getRepoInfo(searchText: userName)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
            tableview.topAnchor.constraint(equalTo: centerYAnchor),
            tableview.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
