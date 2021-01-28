//
//  ViewController.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 22/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
   
    @IBOutlet private weak var userTableView: UITableView!
    private var dataSource: UsersTableViewDataSource?

}

// MARK: UserViewController

extension UsersViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let users: [User] = Loader.loadDataFromJSONFile(withName: "Users") else {
            return
        }
        let dataSource = UsersTableViewDataSource(users: users)
        self.dataSource = dataSource
        userTableView.dataSource = dataSource
        userTableView.reloadData()
    }
}
