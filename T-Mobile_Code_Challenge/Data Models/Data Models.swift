//
//  Data Models.swift
//  T-Mobile_Code_Challenge
//
//  Created by mcs on 4/12/20.
//  Copyright © 2020 MCS. All rights reserved.
//

import UIKit

struct GitUser: Decodable {
    var items: [User]?
}

struct User: Decodable {
    var login: String?
    var avatar_url: String?
}
