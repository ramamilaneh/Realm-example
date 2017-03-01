//
//  MessageCell.swift
//  Realm-example
//
//  Created by Rama Milaneh on 2/28/17.
//  Copyright © 2017 Rama Milaneh. All rights reserved.
//

import UIKit

class MessageCell: UICollectionViewCell {
    
    var messageView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    func setupViews() {
        self.addSubview(messageView)
        self.messageView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":messageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":messageView]))
        self.messageView.font = UIFont.systemFont(ofSize: 16)
    }
}
