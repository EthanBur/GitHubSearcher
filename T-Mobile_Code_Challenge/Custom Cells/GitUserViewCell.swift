//
//  GitUserViewCell.swift
//  T-Mobile_Code_Challenge
//
//  Created by mcs on 4/12/20.
//  Copyright © 2020 MCS. All rights reserved.
//

import UIKit

class GitUserViewCell: UITableViewCell {
    let repoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let forksLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    let starsLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()

    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellView() {
        addSubview(repoLabel)
        addSubview(forksLabel)
        addSubview(starsLabel)
        
        self.topAnchor.constraint(equalTo: topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        repoLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        repoLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        repoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        repoLabel.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: 250).isActive = true
        repoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        forksLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        forksLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        forksLabel.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: 60).isActive = true
        forksLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        starsLabel.topAnchor.constraint(equalTo: forksLabel.bottomAnchor).isActive = true
        starsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        starsLabel.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: 60).isActive = true
        starsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
