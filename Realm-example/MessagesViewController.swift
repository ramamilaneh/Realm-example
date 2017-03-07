//
//  MessagesViewController.swift
//  Realm-example
//
//  Created by Rama Milaneh on 2/27/17.
//  Copyright © 2017 Rama Milaneh. All rights reserved.
//

import UIKit
import RealmSwift

class MessagesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    
    var friend: Friend?
    var messages = [Message]()
    let sendMessageView = UIView()
    let inputTextField = UITextField()
    var bottomConstrain: NSLayoutConstraint?
    var sendButton = UIButton()
    let store = DataStore.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = friend?.name
        self.setupSendMessageView()
        self.collectionView?.register(MessageCell.self, forCellWithReuseIdentifier: "messageCell")
        collectionView?.register(SectionView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
      self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 48)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        gesture.minimumPressDuration = 0.5
        gesture.delaysTouchesBegan = true
        gesture.delegate = self
        self.collectionView?.addGestureRecognizer(gesture)
        
    }
    
    // scroll the collection view to the last item
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.fetchMessages()
        self.messages = (friend?.messages.sorted(by: { (message1, message2) in
            return message1.date?.compare(message2.date!) == .orderedAscending
        }))!
       
        let index = IndexPath(item: self.messages.count - 1, section: 0)
        self.collectionView?.isScrollEnabled = true
        self.collectionView?.scrollToItem(at: index, at: .bottom, animated: true)
    }
    
    
    func setupSendMessageView() {
        self.view.addSubview(sendMessageView)
        self.sendMessageView.addSubview(inputTextField)
        self.sendMessageView.addSubview(sendButton)
        
        self.sendMessageView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        self.sendMessageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(48)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":sendMessageView]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":sendMessageView]))
        bottomConstrain = NSLayoutConstraint(item: sendMessageView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
        self.view.addConstraint(bottomConstrain!)
        
        self.inputTextField.placeholder = "Type a message"
        self.inputTextField.translatesAutoresizingMaskIntoConstraints = false
        self.sendMessageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":inputTextField]))
        
        self.sendButton.translatesAutoresizingMaskIntoConstraints = false
        self.sendMessageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":sendButton]))
        self.sendMessageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0][v1(60)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":inputTextField, "v1":sendButton]))
        self.sendButton.setTitle("Send", for: .normal)
        self.sendButton.backgroundColor = UIColor.clear
        self.sendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.sendButton.setTitleColor(UIColor.lightBlue, for: .normal)
        self.sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        
    }
    

    // MARK: - collection view data source
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let size = self.messages.count
        return size
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "messageCell", for: indexPath) as! MessageCell
        cell.message = messages[indexPath.item]
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
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0 , bottom: 0, right: 0)
//    }
    
   // detect when the user click on an item to hide the keyboard
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.inputTextField.endEditing(true)
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var view : UICollectionReusableView? = nil
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! SectionView
          //  header.dateLabel.text = "hi...."
            header.backgroundColor = .clear
            view = header
        }
        return view!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 40)
    }
    
    
    func handleKeyboard(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardframe = userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
            let isKeyboradShowing = notification.name == .UIKeyboardWillShow
            // change the bottom constrain of the send message viewbased on the keyboard situation
            bottomConstrain?.constant = isKeyboradShowing ? -keyboardframe.height : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: {(success) in
                // scroll the collection view to the last item
                if isKeyboradShowing {
                    let index = IndexPath(item: self.messages.count - 1, section: 0)
                    self.collectionView?.scrollToItem(at: index, at: UICollectionViewScrollPosition.bottom, animated: true)
                }
            })
        }
    }
    
    func sendMessage() {
        let newMessage = Message(text: self.inputTextField.text, date: Date(), friend: self.friend, isSender: true)
        
        try! store.realm.write {
            store.realm.add(newMessage)
            store.fetchMessages()
            self.messages.append(newMessage)
            let lastIndex = IndexPath(item: self.messages.count - 1, section: 0)
            self.collectionView?.insertItems(at: [lastIndex])
            self.collectionView?.scrollToItem(at: lastIndex, at: .bottom, animated: true)
            self.inputTextField.text = nil
        }

    }
    
    func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        
        let p = gestureReconizer.location(in: self.collectionView)
        print(p)
        let indexPath = self.collectionView?.indexPathForItem(at: p)
        if let index = indexPath {
            let attributedString = NSAttributedString(string: "Do you want to delete this message?", attributes: [
                NSFontAttributeName : UIFont.systemFont(ofSize: 18),NSForegroundColorAttributeName : UIColor(white: 0.3, alpha: 1)])
            let optionMenu = UIAlertController(title: nil, message: "", preferredStyle: .actionSheet)
            optionMenu.setValue(attributedString, forKey: "attributedMessage")
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {
                (alert: UIAlertAction!) -> Void in
                let deletedMessage = self.messages[index.item]
                self.messages.remove(at: index.item)
                try! self.store.realm.write {
                    self.store.realm.delete(deletedMessage)
                }
                self.store.fetchMessages()
                self.collectionView?.reloadData()
            })
            
          
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                (alert: UIAlertAction!) -> Void in
                print("Cancelled")
            })
            
            optionMenu.addAction(deleteAction)
            optionMenu.addAction(cancelAction)
            self.present(optionMenu, animated: true, completion: nil)
        }else {
            print("Could not find index path")
        }
    }
    
    func getGroupedMessage() {
        var dates: Array<Date> = Array()
        
        dates.append(self.messages.first!.date!)
        
        for message in self.messages {
            var sameDay: Bool = false
            for date in dates {
                if NSCalendar.current.isDate(date, inSameDayAs:message.date!) {
                    sameDay = true
                    break
                }
            }
            if !sameDay {
                dates.append(message.date!)
            }
        }
        
        var grouped: Dictionary<Date, Array<Message>> = Dictionary()
        
        for date in dates {
            var dateEvents: Array<Message> = Array()
            for message in self.messages {
                if NSCalendar.current.isDate(message.date!, inSameDayAs: date) {
                    dateEvents.append(message)
                }
            }
            grouped[date] = dateEvents
        }
        print("######### \(grouped)")
    }
}
