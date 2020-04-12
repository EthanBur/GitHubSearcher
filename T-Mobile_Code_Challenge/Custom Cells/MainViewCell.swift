//
//  MainViewCell.swift
//  T-Mobile_Code_Challenge
//
//  Created by mcs on 4/11/20.
//  Copyright © 2020 MCS. All rights reserved.
//

import UIKit

class MainViewCell: UITableViewCell {
    let userLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userImage: UIImageView = {
        let userImage = UIImageView()
        userImage.translatesAutoresizingMaskIntoConstraints = false
        return userImage
    }()
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellView() {
        addSubview(userLabel)
        addSubview(userImage)
        self.topAnchor.constraint(equalTo: topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        userImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        userImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5).isActive = true
        userImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        
        userLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        userLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        userLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor).isActive = true
        userLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
