//
//  FriendsViewController.swift
//  Realm-example
//
//  Created by Rama Milaneh on 2/6/17.
//  Copyright © 2017 Rama Milaneh. All rights reserved.
//

import UIKit
import RealmSwift

class RecentViewController: UITableViewController {

    let store = DataStore.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Recent"
      //  store.createFreinds()
      print(Realm.Configuration.defaultConfiguration.fileURL!)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.fetchMessages()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.messages.count
    }

    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentCell", for: indexPath) as! RecentCell
       cell.recentView.message = store.messages[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let layout = UICollectionViewFlowLayout()
            let controller = MessagesViewController(collectionViewLayout: layout)
            controller.friend = store.messages[indexPath.row].friend
            navigationController?.pushViewController(controller, animated: true)
    }
   
}
