//
//  DataStore.swift
//  Realm-example
//
//  Created by Rama Milaneh on 2/27/17.
//  Copyright © 2017 Rama Milaneh. All rights reserved.
//

import Foundation
import RealmSwift

class DataStore {
    static let sharedInstance = DataStore()
    var freinds = try! Realm().objects(Friend.self)
    private init() {}
    func createFreinds() {
        let oprah = Friend(name: "Oprah Winfrey", profileImageName: "oprah")
        let lisa = Friend(name: "Lisa Simpson", profileImageName: "lisa")
        let ramsay = Friend(name: "Chef ramsay", profileImageName: "ramsay")
        let adele = Friend(name: "Adele", profileImageName: "adele")
        let sheldon = Friend(name: "sheldon Cooper", profileImageName: "sheldon")
        // Get the default Realm
        let realm = try! Realm()
        // You only need to do this once (per thread)
        
        // Add to the Realm inside a transaction
        try! realm.write {
            realm.add(oprah)
            realm.add(lisa)
            realm.add(ramsay)
            realm.add(adele)
            realm.add(sheldon)
        }

    }

}
