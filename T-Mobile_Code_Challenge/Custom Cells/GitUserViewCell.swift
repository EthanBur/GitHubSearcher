//
//  GitUserViewCell.swift
//  T-Mobile_Code_Challenge
//
//  Created by mcs on 4/12/20.
//  Copyright © 2020 MCS. All rights reserved.
//

import UIKit

final class GitUserViewCell: UITableViewCell {
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
        
        repoLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        repoLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        repoLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        repoLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        forksLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        forksLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true

        starsLabel.topAnchor.constraint(equalTo: forksLabel.bottomAnchor).isActive = true
        starsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
}
