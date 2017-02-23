//
//  FriendCell.swift
//  Realm-example
//
//  Created by Rama Milaneh on 2/23/17.
//  Copyright © 2017 Rama Milaneh. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {

    @IBOutlet weak var friendView: FriendView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
