//
//  RepositoriesTableViewDataSource.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 28/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

class RepositoriesTableViewDataSource: NSObject {
    let dataOrganizer: ArrayDataSourceOrganizer<Repository>
    var viewModelCache: [IndexPath: RepositoryCell.ViewModel] = [:]
    
    init(repositories: [Repository]) {
        dataOrganizer = ArrayDataSourceOrganizer(items: repositories)
        super.init()
    }
}

// MARK: ArrayTableViewDataSource
extension RepositoriesTableViewDataSource: ArrayTableViewDataSource {
    func viewModel(for value: Repository) -> RepositoryCell.ViewModel {
        return RepositoryCell.ViewModel(repository: value)
    }
    
    func configure(cell: RepositoryCell, with viewModel: RepositoryCell.ViewModel) {
        cell.viewModel = viewModel
    }
}

// MARK: UITableViewDataSource
extension RepositoriesTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell(from: tableView, for: indexPath)
    }
}

// MARK: - RepositoryCell.ViewModel
extension RepositoryCell.ViewModel {
    init(repository: Repository) {
        name = repository.name
        username = repository.owner.login
        description = repository.description ?? ""
        language = repository.language ?? ""
        starsCount = repository.stargazersCount
        forksCount = repository.forksCount
        avatar = #imageLiteral(resourceName: "Avatar")
        date = repository.updateDate
    }
}


