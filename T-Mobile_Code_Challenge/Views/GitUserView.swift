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
    
    let avatarImage: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let userNameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let locationLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let joinDateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let followersLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let followingLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let biographyLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let repoSearchBar: UISearchBar = {
        let repoSearchBar = UISearchBar()
        repoSearchBar.placeholder = "Search For Repos"
        return repoSearchBar
    }()
    
    weak var controller: UIViewController?
    var gitUserRepos: [UserRepo] = []
    var filteredRepos: [String] = []
    var user: User!
//    var filteredUserImageUrl: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(GitUserViewCell.self, forCellReuseIdentifier: "Cell")
        setupViews()
    }
    
    convenience init (user: User) {
        self.init(frame: .zero)
        self.user = user
        guard let userName = self.user.login else {return}
        getRepoInfo(searchText: userName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(tableview)
        addSubview(biographyLabel)
        addSubview(followersLabel)
        addSubview(followingLabel)
        addSubview(joinDateLabel)
        addSubview(locationLabel)
        addSubview(emailLabel)
        addSubview(userNameLabel)
        addSubview(avatarImage)
        addSubview(repoSearchBar)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableview.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableview.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableview.topAnchor.constraint(equalTo: centerYAnchor),
            
            repoSearchBar.bottomAnchor.constraint(equalTo: tableview.topAnchor),
            repoSearchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            repoSearchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            biographyLabel.bottomAnchor.constraint(equalTo: repoSearchBar.topAnchor),
            biographyLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            biographyLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            biographyLabel.topAnchor.constraint(equalTo: repoSearchBar.topAnchor, constant: -50),
            
            avatarImage.bottomAnchor.constraint(equalTo: biographyLabel.topAnchor),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatarImage.trailingAnchor.constraint(equalTo: centerXAnchor),
            avatarImage.topAnchor.constraint(equalTo: topAnchor),
            
            followingLabel.bottomAnchor.constraint(equalTo: biographyLabel.topAnchor),
            followingLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor),
            followingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            followingLabel.topAnchor.constraint(equalTo: biographyLabel.topAnchor, constant: -30),
            
            followersLabel.bottomAnchor.constraint(equalTo: followingLabel.topAnchor),
            followersLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor),
            followersLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            followersLabel.topAnchor.constraint(equalTo: followingLabel.topAnchor, constant: -30),
            
            joinDateLabel.bottomAnchor.constraint(equalTo: followersLabel.topAnchor),
            joinDateLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor),
            joinDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            joinDateLabel.topAnchor.constraint(equalTo: followersLabel.topAnchor, constant: -30),
            
            locationLabel.bottomAnchor.constraint(equalTo: joinDateLabel.topAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            locationLabel.topAnchor.constraint(equalTo: joinDateLabel.topAnchor, constant: -30),
            
            emailLabel.bottomAnchor.constraint(equalTo: locationLabel.topAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            emailLabel.topAnchor.constraint(equalTo: locationLabel.topAnchor, constant: -30),
            
            userNameLabel.bottomAnchor.constraint(equalTo: emailLabel.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            userNameLabel.topAnchor.constraint(equalTo: emailLabel.topAnchor, constant: -30)
        ])
    }
}
