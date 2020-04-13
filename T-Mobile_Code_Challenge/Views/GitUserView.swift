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
        label.numberOfLines = 0
        return label
    }()
    
    let repoSearchBar: UISearchBar = {
        let repoSearchBar = UISearchBar()
        repoSearchBar.translatesAutoresizingMaskIntoConstraints = false
        repoSearchBar.placeholder = "Search For Repos"
        return repoSearchBar
    }()
    
    weak var controller: UIViewController?
    var gitUserRepos: [UserRepo] = []
    var filteredRepos: [String] = []
    var user: User!
    var addUserInfo: additionalUser!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        tableview.delegate = self
        tableview.dataSource = self
        repoSearchBar.delegate = self
        tableview.register(GitUserViewCell.self, forCellReuseIdentifier: "newCell")
        setupViews()
    }
    
    convenience init (user: User, addUserInfo: additionalUser) {
        self.init(frame: .zero)
        self.user = user
        self.addUserInfo = addUserInfo
        let userName = self.user.login
        getRepoInfo(searchText: userName)
        biographyLabel.text = "Biography: \(addUserInfo.bio ?? "No biography found")"
        followersLabel.text = "Followers: \(addUserInfo.followers?.description ?? "No followers found")"
        followingLabel.text = "Following: \(addUserInfo.following?.description ?? "User is not following anyone")"
        joinDateLabel.text = "Date Joined: \(addUserInfo.created_at ?? "Account creation date not found")"
        locationLabel.text = "Location: \(addUserInfo.location ?? "Location not found")"
        emailLabel.text = "Email: \(addUserInfo.email ?? "Email not found")"
        userNameLabel.text = "Name: \(addUserInfo.name ?? "Name not found")"
        avatarImage.downloadImageFrom(link: user.avatar_url ?? "https://secure.gravatar.com/avatar/25c7c18223fb42a4c6ae1c8db6f50f9b?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png", contentMode: .scaleAspectFit)
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
            avatarImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatarImage.heightAnchor.constraint(equalToConstant: 200),
            avatarImage.widthAnchor.constraint(equalTo: avatarImage.heightAnchor, multiplier: 5/7),
            
            userNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 10),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 10),
            emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 10),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            joinDateLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 10),
            joinDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            joinDateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            
            followersLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 10),
            followersLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            followersLabel.topAnchor.constraint(equalTo: joinDateLabel.bottomAnchor, constant: 10),
            
            followingLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 10),
            followingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            followingLabel.topAnchor.constraint(equalTo: followersLabel.bottomAnchor, constant: 10),
            
            biographyLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor),
            biographyLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            biographyLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            repoSearchBar.topAnchor.constraint(equalTo: biographyLabel.bottomAnchor),
            repoSearchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            repoSearchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            repoSearchBar.heightAnchor.constraint(equalToConstant: 50),

            tableview.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableview.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableview.topAnchor.constraint(equalTo: repoSearchBar.bottomAnchor)
        ])
    }
}
