//
//  EditProfileTableViewDataSource.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 4/2/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

class EditProfileTableViewDataSource: NSObject {
    private var organizer: DataOrganizer
    
    init(user: User) {
        organizer = DataOrganizer(user: user)
    }
}

// MARK: UITableViewDataSource

extension EditProfileTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizer.rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = organizer.row(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(with: row.cellType, for: indexPath)
        cell.separator = row.separator
        if let configurableCell = cell as? RowConfigurable {
            configurableCell.configure(with: row)
        }
        return cell
    }
}

// MARK: - DataOrganizer

extension EditProfileTableViewDataSource {
    struct DataOrganizer  {
        private (set) var rows: [EditProfileViewController.Row]
        
        var rowsCount: Int {
            return rows.count
        }
        
        init(user: User) {
            let rows: [EditProfileViewController.Row] =
                [.avatar(UIImage()), .name(""), .blog(""), .company(""), .location(""), .bio("")]
            self.rows = rows.map { user[$0] }
        }
        
        func row(at index: Int) -> EditProfileViewController.Row {
            return rows[index]
        }
    }
}

// MARK: RowConfigurable

protocol RowConfigurable {
    func configure(with row: EditProfileViewController.Row)
}

extension AvatarInputCell: RowConfigurable {
    func configure(with row: EditProfileViewController.Row) {
        avatar = #imageLiteral(resourceName: "Avatar")
    }
}

extension DetailInputCell: RowConfigurable {
    func configure(with row: EditProfileViewController.Row) {
        switch row {
            case let .name(text), let .blog(text), let .company(text), let .location(text):
                let isValid: Bool = {
                    if case .blog(_) = row {
                        return text.isValidURL
                    } else {
                        return true
                    }
                }()
                viewModel = ViewModel(label: row.label, text: text, placeholder: row.placeHolder, errorMessage: row.errorMessage, isValid: isValid)
            case .avatar, .bio:
                assertionFailure("InputCell is not configurable with an .avatar or .bio row")
        }
    }
}

extension BioInputCell: RowConfigurable {
    func configure(with row: EditProfileViewController.Row) {
        if case let .bio(text) = row {
            self.bioText = text
        } else {
            assertionFailure("BioInputCell in not configurable with a row other than .bio")
        }
    }
}

// MARK: - String
extension String {
    var isValidURL: Bool {
        return URL(string: self) != nil
    }
}

