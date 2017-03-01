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
    let sendMessageView = UIView()
    let inputTextField = UITextField()
    var bottomConstrain: NSLayoutConstraint?
    var sendButton = UIButton()
    
    // ceate collection view
    lazy var messagesCollectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
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
        self.setupSendMessageView()
        self.messagesCollectionView.register(MessageCell.self, forCellWithReuseIdentifier: "messageCell")
        // sort the messages based on the date in ascending order
        self.messages = (friend?.messages.sorted(by: { (message1, message2) in
            return message1.date?.compare(message2.date!) == .orderedAscending
        }))!
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

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
        self.sendMessageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":inputTextField]))
        self.sendMessageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":inputTextField]))
        
        self.sendButton.translatesAutoresizingMaskIntoConstraints = false
        self.sendMessageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":sendButton]))
        self.sendMessageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0][v1(60)]-4-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":inputTextField, "v1":sendButton]))
        self.sendButton.setTitle("Send", for: .normal)
        self.sendButton.backgroundColor = UIColor.clear
        self.sendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.sendButton.setTitleColor(UIColor.lightBlue, for: .normal)
        
    }

    func handleKeyboard(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardframe = userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
            let isKeyboradShowing = notification.name == .UIKeyboardWillShow
            bottomConstrain?.constant = isKeyboradShowing ? -keyboardframe.height : 0
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: { 
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.inputTextField.endEditing(true)
    }
}
