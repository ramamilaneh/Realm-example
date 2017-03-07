//
//  SectionView.swift
//  Realm-example
//
//  Created by Rama Milaneh on 3/6/17.
//  Copyright © 2017 Rama Milaneh. All rights reserved.
//

import UIKit

class SectionView: UICollectionReusableView {
    
    let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
        
    }
    
    func commonInit(){
      self.addSubview(dateLabel)
        self.backgroundColor = UIColor.cyan
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(40)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":dateLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-150-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":dateLabel]))
        self.dateLabel.text = "date 3/6/2017"
        self.dateLabel.textColor = UIColor(white: 0.5, alpha: 1)
    }
        
}
