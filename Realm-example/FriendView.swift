//
//  FriendView.swift
//  Realm-example
//
//  Created by Rama Milaneh on 2/6/17.
//  Copyright © 2017 Rama Milaneh. All rights reserved.
//

import UIKit

class FriendView: UIView {

    @IBOutlet var contentView: UIView!
    let friendImage = UIImageView()
    let dividerLineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("FriendView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentView)
        self.contentView.constrainViewToEdges(of: self)
        //self.contentView.backgroundColor = UIColor.lightGray
        self.setupViews()
    }
    
    func setupViews() {
        self.contentView.addSubview(friendImage)
        self.contentView.addSubview(dividerLineView)
        
        self.friendImage.contentMode = .scaleAspectFill
        self.friendImage.layer.cornerRadius = 34
        self.friendImage.clipsToBounds = true
        self.friendImage.image = UIImage(named: "oprah")
        self.friendImage.translatesAutoresizingMaskIntoConstraints = false
        _ = self.friendImage.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 4, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 68, heightConstant: 68)
        
        self.dividerLineView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        self.dividerLineView.translatesAutoresizingMaskIntoConstraints = false
        _ = self.dividerLineView.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 82, bottomConstant: 0, rightConstant: 2, widthConstant: 0, heightConstant: 1)
    }

}
