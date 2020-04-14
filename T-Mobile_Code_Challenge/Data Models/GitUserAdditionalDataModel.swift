//
//  GitUserAdditionalDataModel.swift
//  T-Mobile_Code_Challenge
//
//  Created by mcs on 4/13/20.
//  Copyright © 2020 MCS. All rights reserved.
//

import UIKit

struct AdditionalUser: Decodable {
    var name: String?
    var email: String?
    var location: String?
    var bio: String?
    var publicRepos: Int?
    var followers: Int?
    var following: Int?
    var createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case email
        case location
        case bio
        case followers
        case following
        case publicRepos = "public_repos"
        case createdAt = "created_at"
    }
}
