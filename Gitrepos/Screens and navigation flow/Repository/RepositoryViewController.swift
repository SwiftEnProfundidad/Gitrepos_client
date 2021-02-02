//
//  RepositoryViewController.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 28/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

class RepositoryViewController: UIViewController {
    @IBOutlet private weak var repositoryTableView: UITableView!
    private var dataSource: RepositoryTableViewDataSource?
}

// MARK: UIViewController
extension RepositoryViewController {
    override func viewDidLoad() {
        guard var repository: Repository = Loader.loadDataFromJSONFile(withName: "Repository") else {
            return
        }
        let readMeURL = URL(string: "https://github.com/octokit/octokit.rb/blob/master/README.md")!
        repository.readMe = FetchableValue(url: readMeURL, value: .fetched(value: ""))
        let dataSource = RepositoryTableViewDataSource(repository: repository)
        self.dataSource = dataSource
        repositoryTableView.dataSource = dataSource
        super.viewDidLoad()
    }
}

// MARK: - Row
extension RepositoryViewController {
    enum Row {
        case name
        case parent
        case owner
        case description
        case counters
        case date
        case readme
        
        var cellType: UITableViewCell.Type {
            switch self {
                case .name: return RepositoryNameCell.self
                case .parent: return ParentCell.self
                case .owner: return OwnerCell.self
                case .description: return DescriptionCell.self
                case .counters: return CountersCell.self
                case .date: return DateCell.self
                case .readme: return ReadmeCell.self
            }
        }
    }
}


