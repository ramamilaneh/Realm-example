//
//  Message.swift
//  Realm-example
//
//  Created by Rama Milaneh on 2/27/17.
//  Copyright © 2017 Rama Milaneh. All rights reserved.
//

import Foundation
import RealmSwift

class Message: Object {
    
    dynamic var text: String?
    dynamic var date: Date?
    dynamic var friend: Friend? // one to one relationship
    dynamic var isSender = false
    
    convenience init(text: String?, date: Date?, friend: Friend?, isSender: Bool) {
        self.init()
        let text = text ?? ""
        self.text = text
        self.date  = date
        self.friend = friend
        self.isSender = isSender
    }

    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
