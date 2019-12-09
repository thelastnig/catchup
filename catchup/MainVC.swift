//
//  MainVC.swift
//  catchup
//
//  Created by PJW on 2019/12/09.
//  Copyright © 2019 PJW. All rights reserved.
//

import UIKit

class MainVC: UITableViewController {
    @IBOutlet var btnSideBar: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let revealVC = self.revealViewController() {
            self.btnSideBar.target = revealVC
            self.btnSideBar.action = #selector(revealVC.revealToggle(_:))
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }



}
