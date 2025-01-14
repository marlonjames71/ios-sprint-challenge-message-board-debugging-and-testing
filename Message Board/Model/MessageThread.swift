//
//  MessageThread.swift
//  Message Board
//
//  Created by Spencer Curtis on 8/7/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable {

    let title: String
    var messages: [MessageThread.Message]
	let dateCreated: Date
    let identifier: String
	

	init(title: String, dateCreated: Date = Date(), messages: [MessageThread.Message] = [], identifier: String = UUID().uuidString) {
        self.title = title
        self.messages = messages
        self.identifier = identifier
		self.dateCreated = dateCreated
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let title = try container.decode(String.self, forKey: .title)
		let date = try container.decode(Date.self, forKey: .dateCreated)
        let identifier = try container.decode(String.self, forKey: .identifier)
		let messageDict = try container.decodeIfPresent([String: Message].self, forKey: .messages) ?? [:]
		self.messages = Array(messageDict.values)
        
        self.title = title
		self.dateCreated = date
        self.identifier = identifier
    }

    
    struct Message: Codable, Equatable {
        
        let text: String
        let sender: String
        let timestamp: Date
        
        init(text: String, sender: String, timestamp: Date = Date()) {
            self.text = text
            self.sender = sender
            self.timestamp = timestamp
        }
    }
    
    static func ==(lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title &&
            lhs.identifier == rhs.identifier &&
            lhs.messages == rhs.messages
    }
}
