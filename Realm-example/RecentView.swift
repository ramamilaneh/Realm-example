//
//  FriendView.swift
//  Realm-example
//
//  Created by Rama Milaneh on 2/6/17.
//  Copyright © 2017 Rama Milaneh. All rights reserved.
//

import UIKit

class RecentView: UIView {

    @IBOutlet var contentView: UIView!
    let friendImage = UIImageView()
    let dividerLineView = UIView()
    let messageView = UIView()
    let nameLabel = UILabel()
    let messageLabel = UILabel()
    let timeLabel = UILabel()
    var message: Message? {
        didSet {
            self.nameLabel.text = message?.friend?.name
            if let profileImageName = message?.friend?.profileImageName {
                friendImage.image = UIImage(named: profileImageName)
            }

            if let date = message?.date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                timeLabel.text = dateFormatter.string(from: date)
            }
           let text = message?.text ?? ""
            self.messageLabel.text = text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("RecentView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentView)
        self.contentView.constrainViewToEdges(of: self)
        self.setupViews()
    }
    
    func setupViews() {
        self.contentView.addSubview(friendImage)
        self.contentView.addSubview(dividerLineView)
        setupMessageView()
        self.friendImage.contentMode = .scaleAspectFill
        self.friendImage.layer.cornerRadius = 34
        self.friendImage.clipsToBounds = true
       // self.friendImage.image = UIImage(named: "oprah")
        self.friendImage.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[v0(68)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":friendImage]))
         addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(68)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":friendImage]))
        addConstraint(NSLayoutConstraint(item: friendImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        self.dividerLineView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        self.dividerLineView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-82-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":dividerLineView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":dividerLineView]))
    }
    
    func setupMessageView() {
        self.contentView.addSubview(messageView)
        self.messageView.addSubview(nameLabel)
        self.messageView.addSubview(messageLabel)
        self.messageView.addSubview(timeLabel)
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.messageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.timeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.messageView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-90-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":messageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(50)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":messageView]))
        addConstraint(NSLayoutConstraint(item: messageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        self.messageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0][v1(80)]-12-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":nameLabel , "v1":timeLabel]))
       self.messageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0][v1(24)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":nameLabel , "v1":messageLabel]))
        self.messageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":messageLabel]))
       self.messageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(24)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":timeLabel]))
      
       // self.nameLabel.text = "Oprah Winfry"
        self.nameLabel.font = UIFont.systemFont(ofSize: 18)
       // self.messageLabel.text = "message from your friend Oprah...."
        self.messageLabel.font = UIFont.systemFont(ofSize: 14)
        self.messageLabel.textColor = UIColor.darkGray
      //  self.timeLabel.text = "2:50 pm"
        self.timeLabel.textAlignment = .right
        self.timeLabel.font = UIFont.systemFont(ofSize: 16)
    }

}
