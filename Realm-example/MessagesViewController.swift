//
//  MessagesViewController.swift
//  Realm-example
//
//  Created by Rama Milaneh on 2/27/17.
//  Copyright © 2017 Rama Milaneh. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {

    var friend: Friend?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = friend?.name

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
