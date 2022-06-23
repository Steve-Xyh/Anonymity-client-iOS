//
//  File Name     : User.swift
//  Project Name  : Anonymity
//  Description   : User data model
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/6/23 23:59.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import Foundation

struct User {
    // TODO: (Steve X): change uuid to hash(username)
    let id: String = UUID().uuidString
    let username: String
    let password: String
    let avatar_url: String
}
