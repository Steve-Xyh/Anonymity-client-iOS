//
//  File Name     : Chat.swift
//  Project Name  : Anonymity
//  Description   : Chat model with single or multiple users
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/6/28 17:37.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import Foundation

struct Chat: Identifiable, Equatable {
    var id: String = UUID().uuidString
    var person: [User]
    var messages: [Message]
    var type: ChatType {
        if person.count == 2 {
            return .single
        } else {
            return .group
        }
    }
}

extension Chat {
    enum ChatType {
        case single
        case group
    }

    static func == (lhs: Chat, rhs: Chat) -> Bool {
        return lhs.id == rhs.id
    }

    init(by creator: User, with person: [User], messages: [Message] = []) {
        self.person = person
        self.messages = messages

        if person.count == 1 {
            id = creator.id + person[0].id
        }

        self.person.append(creator)
    }

    /// Fetch Chat instance from database in DataService
    /// - Parameter id: Chat ID
    init?(for id: Chat.ID) {
        guard let chat = ChatDataService.chats.first(where: { $0.id == id }) else { return nil }
        self = chat
    }
}
