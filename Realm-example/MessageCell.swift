//
//  MessageCell.swift
//  Realm-example
//
//  Created by Rama Milaneh on 2/28/17.
//  Copyright © 2017 Rama Milaneh. All rights reserved.
//

import UIKit
import Foundation

class MessageCell: UICollectionViewCell {
    
    var messageView = UITextView()
    let textBubbleView = UIView()
    let profileImageView = UIImageView()
    static let grayBubbleImage = UIImage(named: "bubble_gray")!.resizableImage(withCapInsets: UIEdgeInsetsMake(22, 26, 22, 26)).withRenderingMode(.alwaysTemplate)
    static let blueBubbleImage = UIImage(named: "bubble_blue")!.resizableImage(withCapInsets: UIEdgeInsetsMake(22, 26, 22, 26)).withRenderingMode(.alwaysTemplate)
    let bubbleImageView = UIImageView()
    
    var message: Message? {
        didSet {
            if let message = message,let messageText = message.text {
                self.messageView.text = messageText
                let size = CGSize(width: 250, height: 1000)
                let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin.union(.usesLineFragmentOrigin), attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 18)], context: nil)
                // Handle the sender
                if message.isSender {
                    self.messageView.frame = CGRect(x: self.frame.width - estimatedFrame.width - 16 - 16 - 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                    self.textBubbleView.frame = CGRect(x: self.frame.width - estimatedFrame.width - 16 - 8 - 16 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
                    self.profileImageView.isHidden = true
                    self.messageView.textColor = UIColor.white
                    self.bubbleImageView.image = MessageCell.blueBubbleImage
                    self.bubbleImageView.tintColor = UIColor.lightBlue
                }else{
                    self.messageView.frame = CGRect(x:48 + 8, y:0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                    
                    self.textBubbleView.frame = CGRect(x:48 - 10, y:-4, width: estimatedFrame.width + 16 + 8 + 16, height: estimatedFrame.height + 20 + 6)
                    self.bubbleImageView.image = MessageCell.grayBubbleImage
                    self.bubbleImageView.tintColor = UIColor(white: 0.95, alpha: 1)
                    self.messageView.textColor = UIColor.black
                }
            }
            if let profileImageName = message?.friend?.profileImageName {
                profileImageView.image = UIImage(named: profileImageName)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    func setupViews() {
        self.addSubview(textBubbleView)
        self.addSubview(messageView)
        self.addSubview(profileImageView)
        self.textBubbleView.addSubview(bubbleImageView)
        
        self.messageView.font = UIFont.systemFont(ofSize: 18)
        self.messageView.backgroundColor = UIColor.clear
        self.messageView.isEditable = false
        self.textBubbleView.layer.cornerRadius = 15
        self.textBubbleView.clipsToBounds = true
        self.profileImageView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(30)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":profileImageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0(30)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":profileImageView]))
        self.profileImageView.contentMode = .scaleAspectFill
        self.profileImageView.layer.cornerRadius = 15
        self.profileImageView.clipsToBounds = true
        self.bubbleImageView.image = MessageCell.grayBubbleImage
        self.bubbleImageView.tintColor = UIColor(white: 0.95, alpha: 1)
        self.bubbleImageView.translatesAutoresizingMaskIntoConstraints = false
        self.textBubbleView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":bubbleImageView]))
        self.textBubbleView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":bubbleImageView]))
        
    }
}
