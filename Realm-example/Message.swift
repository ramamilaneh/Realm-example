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
    
    dynamic var text: String = ""
    dynamic var date: Date?
    dynamic var friend: Friend? // one to one relationship
    
    convenience init(text: String, date: Date) {
        self.init()
        self.text = text
        self.date  = date
    }

    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
