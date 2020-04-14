//
//  UserRepoDataModel.swift
//  T-Mobile_Code_Challenge
//
//  Created by mcs on 4/12/20.
//  Copyright © 2020 MCS. All rights reserved.
//

import UIKit

struct UserRepo: Decodable {
    var name: String
    var starCount: Int
    var forks: Int
    var htmlURL: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case starCount = "stargazers_count"
        case forks
        case htmlURL = "html_url"
    }
}
