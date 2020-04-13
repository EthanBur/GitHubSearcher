//
//  GitUserAdditionalDataModel.swift
//  T-Mobile_Code_Challenge
//
//  Created by mcs on 4/13/20.
//  Copyright © 2020 MCS. All rights reserved.
//

import UIKit

struct additionalUser: Decodable {
    var name: String?
    var email: String?
    var location: String?
    var bio: String?
    var public_repos: Int?
    var followers: Int?
    var following: Int?
    var created_at: String?
}
