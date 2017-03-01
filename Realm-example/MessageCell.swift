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
     var message: Message? {
        didSet {
            if let messageText = message?.text {
                let size = CGSize(width: 250, height: 1000)
                let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin.union(.usesLineFragmentOrigin), attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 18)], context: nil)
                self.messageView.frame = CGRect(x: 56, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                self.textBubbleView.frame = CGRect(x: 48, y: 0, width: estimatedFrame.width + 24, height: estimatedFrame.height + 20)
                self.messageView.text = messageText
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
        
        self.messageView.font = UIFont.systemFont(ofSize: 18)
        self.messageView.backgroundColor = UIColor.clear
        self.textBubbleView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        self.textBubbleView.layer.cornerRadius = 15
        self.textBubbleView.clipsToBounds = true
        self.profileImageView.translatesAutoresizingMaskIntoConstraints = false
         addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(30)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":profileImageView]))
         addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0(30)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":profileImageView]))
        self.profileImageView.contentMode = .scaleAspectFill
        self.profileImageView.layer.cornerRadius = 15
        self.profileImageView.clipsToBounds = true
    }
}
