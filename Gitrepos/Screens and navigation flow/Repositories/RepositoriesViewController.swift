//
//  RepositoriesViewController.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 28/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController, Stateful, MainCoordinated {
    private var dataSource: RepositoriesTableViewDataSource?
    @IBOutlet private weak var repositoryTableView: UITableView!
    
    var stateController: StateController?
    weak var mainCoordinator: MainFlowCoordinator?
}

// MARK: UIViewController
extension RepositoriesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let repositories: [Repository] = Loader.loadDataFromJSONFile(withName: "Repositories") else {
            return
        }
        let dataSource = RepositoriesTableViewDataSource(repositories: repositories)
        self.dataSource = dataSource
        repositoryTableView.dataSource = dataSource
        repositoryTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        mainCoordinator?.configure(viewController: segue.destination)
    }
}

