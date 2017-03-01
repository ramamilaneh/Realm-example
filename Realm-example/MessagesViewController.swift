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
        // sort the messages based on the date in ascending order
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
        cell.message = friend?.messages[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Handel the hight of the cell to be equal to the hight of the text
        if let messageText = friend?.messages[indexPath.item].text {
            let size = CGSize(width: 250, height: 1000)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin.union(.usesLineFragmentOrigin), attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 18)], context: nil)
            return CGSize(width: self.view.frame.width, height: estimatedFrame.height + 20)
        }
        return CGSize(width: self.view.frame.width, height: 100)
    }
    
    // move the text down by 10 pixels
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
}
