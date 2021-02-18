//
//  UsersTableViewDataSource.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 27/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

class UsersTableViewDataSource: NSObject {
    internal var dataOrganizer: ArrayDataSourceOrganizer<User>
    internal var viewModelCache: [IndexPath : UserCell.ViewModel] = [:]
    
    init(users: [User]) {
        dataOrganizer = ArrayDataSourceOrganizer(items: users)
        super.init()
    }
}

// MARK: ArrayTableViewDataSource
extension UsersTableViewDataSource: ArrayTableViewDataSource {
    func viewModel(for value: User) -> UserCell.ViewModel {
        return UserCell.ViewModel(user: value)
    }
    
    func configure(cell: UserCell, with viewModel: UserCell.ViewModel) {
        cell.viewModel = viewModel
    }
}

// MARK: UITableViewDataSource
extension UsersTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell(from: tableView, for: indexPath)
    }
}

// MARK: - DataOrganizer
private extension UsersTableViewDataSource {
    struct DataOrganizer {
        let users: [User]
        
        var rowsCount: Int {
            return users.count
        }
        
        subscript(indexPath: IndexPath) -> User {
            return users[indexPath.row]
        }
    }
}

// MARK: - UserCell.ViewModel
extension UserCell.ViewModel {
    init(user: User) {
        username = user.login
        avatar = #imageLiteral(resourceName: "Avatar")
        guard case let .fetched(details) = user.details.value else {
            return
        }
        name = details.name ?? ""
        bio = details.bio ?? ""
        location = details.location ?? ""
    }
}

