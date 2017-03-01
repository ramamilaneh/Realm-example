//
//  MessagesViewController.swift
//  Realm-example
//
//  Created by Rama Milaneh on 2/27/17.
//  Copyright © 2017 Rama Milaneh. All rights reserved.
//

import UIKit
import RealmSwift

class MessagesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

    var friend: Friend?
    var messages = [Message]()
    // ceate collection view
    lazy var messagesCollectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0 // To get rid of the spacing between pages
        let cv = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.white
        return cv
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = friend?.name
        
        self.view.addSubview(messagesCollectionView)
        self.messagesCollectionView.register(MessageCell.self, forCellWithReuseIdentifier: "messageCell")
        self.messages = (friend?.messages.sorted(by: { (message1, message2) in
            return message1.date?.compare(message2.date!) == .orderedAscending
        }))!

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let size = friend?.messages.count ?? 0
        return size
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "messageCell", for: indexPath) as! MessageCell
        cell.messageView.text = friend?.messages[indexPath.item].text
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 100)
    }
}
