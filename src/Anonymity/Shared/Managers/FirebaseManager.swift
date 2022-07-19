//
//  File Name     : FirebaseManager.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/7/19 21:04.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import Firebase
import Foundation

class FirebaseManager {
    /// FirebaseAuth for authentication
    let auth: Auth

    /// Singleton instance
    static let shared: FirebaseManager = {
        // Firebase configuration
        FirebaseApp.configure()
        let instance = FirebaseManager()

        return instance
    }()

    init() {
        auth = Auth.auth()
    }
}
