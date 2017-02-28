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
    var messages = try! Realm().objects(Message.self)
    private init() {}
    func createFreinds() {
        
        let oprah = Friend(name: "Oprah Winfrey", profileImageName: "oprah")
        let lisa = Friend(name: "Lisa Simpson", profileImageName: "lisa")
//        let ramsay = Friend(name: "Chef ramsay", profileImageName: "ramsay")
//        let adele = Friend(name: "Adele", profileImageName: "adele")
//        let sheldon = Friend(name: "sheldon Cooper", profileImageName: "sheldon")
        let oprahMessage = Message(text: "Hello, my name is Mark. Nice to meet you...", date: Date(), friend: oprah)
        let lisaMessage = Message(text: "Apple creates great iOS Devices for the world...", date: Date(), friend: lisa)
        
        // Get the default Realm
        let realm = try! Realm()
        // Delete all objects before adding
        try! realm.write {
            realm.deleteAll()
        }
        // Add to the Realm inside a transaction
        try! realm.write {
            realm.add(oprah)
            realm.add(lisa)
            realm.add(oprahMessage)
            realm.add(lisaMessage)

//            realm.add(ramsay)
//            realm.add(adele)
//            realm.add(sheldon)
        }

    }

}
