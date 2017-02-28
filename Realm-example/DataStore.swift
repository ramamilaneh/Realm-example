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
    var messages = [Message]()
    private init() {}
    func createFreinds() {
        
        let oprah = Friend(name: "Oprah Winfrey", profileImageName: "oprah")
        let lisa = Friend(name: "Lisa Simpson", profileImageName: "lisa")
//        let ramsay = Friend(name: "Chef ramsay", profileImageName: "ramsay")
//        let adele = Friend(name: "Adele", profileImageName: "adele")
//        let sheldon = Friend(name: "sheldon Cooper", profileImageName: "sheldon")
        let oprahMessage1 = Message(text: "Hello, my name is Mark. Nice to meet you...", date: Date().addingTimeInterval(-2*60), friend: oprah)
        let oprahMessage2 = Message(text: "Nice to meet you...", date: Date().addingTimeInterval(-1*60), friend: oprah)
        let oprahMessage3 = Message(text: "how is everything going?", date: Date().addingTimeInterval(-0*60), friend: oprah)
        let lisaMessage = Message(text: "Apple creates great iOS Devices for the world...", date: Date().addingTimeInterval(-2*60), friend: lisa)
        
        // Get the default Realm
        let realm = try! Realm()
        // Delete all objects before adding
        try! realm.write {
            realm.deleteAll()
        }
        // Add to the Realm inside a transaction
        try! realm.write {
            realm.add([oprah,lisa,oprahMessage1,oprahMessage2,oprahMessage3,lisaMessage])
//            realm.add(ramsay)
//            realm.add(adele)
//            realm.add(sheldon)
        }
        let friends = realm.objects(Friend.self)
        for friend in friends {
            
        let predict = NSPredicate(format: "friend.name = %@", friend.name)
           let fetcehedMessages = realm.objects(Message.self).sorted(byKeyPath: "date", ascending: false).filter(predict).first
            self.messages.append(fetcehedMessages!)
        }
       

    }

}
