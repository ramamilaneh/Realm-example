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
        // Create freinds
        let oprah = Friend(name: "Oprah Winfrey", profileImageName: "oprah")
        let lisa = Friend(name: "Lisa Simpson", profileImageName: "lisa")
        let ramsay = Friend(name: "Chef Ramsay", profileImageName: "ramsay")
        let adele = Friend(name: "Adele", profileImageName: "adele")
        let sheldon = Friend(name: "sheldon Cooper", profileImageName: "sheldon")
        
        // Create the messages
        let oprahMessage1 = Message(text: "Hello, my name is Mark. Nice to meet you...", date: Date().addingTimeInterval(-3*60), friend: oprah, isSender: false)
        let oprahMessage2 = Message(text: "Nice to meet you...Nice to meet you...Nice to meet you...", date: Date().addingTimeInterval(-2*60), friend: oprah, isSender: false)
        let oprahMessage3 = Message(text: "how is everything going?how is everything going?how is everything going?how is everything going?how is everything going?", date: Date().addingTimeInterval(-1*60), friend: oprah, isSender: false)
        let oprahMessage4 = Message(text: "how is everything going?how is everything going?how is everything going?how is everything going?how is everything going?", date: Date().addingTimeInterval(-0*60), friend: oprah, isSender: true)
        let lisaMessage = Message(text: "Apple creates great iOS Devices for the world...", date: Date().addingTimeInterval(-2*60), friend: lisa, isSender: false)
        let ramsyMessage = Message(text: "welcome in Hill's Kitchen", date: Date().addingTimeInterval(-5*60), friend: ramsay, isSender: false)
        let adeleMessage = Message(text: "All of you are invited to my party", date: Date().addingTimeInterval(-24*60*60), friend: adele, isSender: false)
        let sheldonMessage = Message(text: "Don't sit on my spot...!!!!", date: Date().addingTimeInterval(-24*10*60*60), friend: sheldon, isSender: false)
        
        // Get the default Realm
        let realm = try! Realm()
        // Delete all objects before adding
        try! realm.write {
            realm.deleteAll()
        }
        // Add to the Realm inside a transaction
        try! realm.write {
            realm.add([oprah,lisa,ramsay,adele,sheldon,oprahMessage1,oprahMessage2,oprahMessage3,oprahMessage4,lisaMessage,ramsyMessage,adeleMessage,sheldonMessage])
        }
        // Loop inside the friends array to get the last message of each one
        let friends = realm.objects(Friend.self)
        for friend in friends {
            
        let predict = NSPredicate(format: "friend.name = %@", friend.name)
            // search for the messages for each freind and sort them based on date
           let fetcehedMessages = realm.objects(Message.self).sorted(byKeyPath: "date", ascending: false).filter(predict).first ?? Message(text: nil, date: nil, friend: friend, isSender: false)
            self.messages.append(fetcehedMessages)
        }
        // sort the message based on date
        self.messages = self.messages.sorted(by: { (message1, message2) in
           return message1.date?.compare(message2.date!) == .orderedDescending
        })

    }

}
