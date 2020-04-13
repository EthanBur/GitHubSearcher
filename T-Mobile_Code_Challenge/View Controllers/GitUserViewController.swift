//
//  GitUserViewController.swift
//  T-Mobile_Code_Challenge
//
//  Created by mcs on 4/11/20.
//  Copyright © 2020 MCS. All rights reserved.
//

import UIKit

class GitUserViewController: UIViewController {
    
    lazy var gitView = {
        return GitUserView(user: user, addUserInfo: addUserInfo)
    }()
    
    var user: User!
    var addUserInfo: additionalUser!
    
    override func loadView() {
        self.navigationItem.title = "GitHub Searcher"
        self.navigationController?.navigationBar.barTintColor = .gray
//        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: UIFont(name: "Trebuchet MS", size: 35.0)]
//        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        gitView.controller = self
        view = gitView
    }
}
