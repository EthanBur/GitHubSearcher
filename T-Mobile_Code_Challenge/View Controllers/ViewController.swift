//
//  ViewController.swift
//  T-Mobile_Code_Challenge
//
//  Created by mcs on 4/11/20.
//  Copyright © 2020 MCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let mainView = MainView()
    
    override func loadView() {
        self.navigationItem.title = "GitHub Searcher"
        self.navigationController?.navigationBar.barTintColor = .gray
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: UIFont(name: "Trebuchet MS", size: 35.0)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        mainView.controller = self
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

