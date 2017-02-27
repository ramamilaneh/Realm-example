//
//  Friend.swift
//  Realm-example
//
//  Created by Rama Milaneh on 2/27/17.
//  Copyright © 2017 Rama Milaneh. All rights reserved.
//

import Foundation
import RealmSwift

class Friend: Object {
    
    dynamic var name: String = ""
    dynamic var profileImageName: String = ""
    let messages = LinkingObjects(fromType: Message.self, property: "friend")// relationship one to many
    
    convenience init(name: String, profileImageName: String) {
        self.init()
        self.name = name
        self.profileImageName = profileImageName
    }
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
