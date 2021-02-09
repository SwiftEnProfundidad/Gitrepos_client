//
//  EditProfileViewController.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 4/2/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    @IBOutlet private weak var editProfileTableView: UITableView!
    private var dataSource: EditProfileTableViewDataSource?
}

extension EditProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user: User = Loader.loadDataFromJSONFile(withName: "User") else {
            return
        }
        let dataSource = EditProfileTableViewDataSource(user: user)
        self.dataSource = dataSource
        editProfileTableView.dataSource = dataSource
        editProfileTableView.delegate = self
        editProfileTableView.reloadData()
    }
}

// MARK: UITableViewDelegate

extension EditProfileViewController: UITableViewDelegate {
    
}

// MARK: - Row

extension EditProfileViewController {
    enum Row {
        case avatar(UIImage)
        case name(String)
        case blog(String)
        case company(String)
        case location(String)
        case bio(String)
        
        var cellType: UITableViewCell.Type {
            switch self {
                case .avatar: return AvatarInputCell.self
                case .name, .blog, .company, .location: return DetailInputCell.self
                case .bio: return BioInputCell.self
            }
        }
        
        var separator: UITableViewCell.SeparatorType {
            switch self {
                case .avatar: return .none
                case .name, .blog, .company, .location, .bio: return .insetted(24.0)
            }
        }
        
        var label: String {
            switch self {
                case .name: return "Name"
                case .blog: return "Blog"
                case .company: return "Company"
                case .location: return "Location"
                case .bio: return "Bio"
                case .avatar: assertionFailure("The avatar has no label")
                    return ""
            }
        }
        
        var placeHolder: String {
            switch self {
                case .name: return "Name or nickname"
                case .blog: return "example.com"
                case .company: return "Company name"
                case .location: return "City"
                case .bio: return "Tell us a bit about yourself"
                case .avatar:
                    assertionFailure("The avatar has no placeholder")
                    return ""
            }
        }
        
        var errorMessage: String {
            switch self {
                case .name, .company, .location: return ""
                case .blog: return "The URL is not valid"
                case .bio:
                    assertionFailure("The bio has no error message")
                    return ""
                case .avatar:
                    assertionFailure("The avatar has no error message")
                    return ""
            }
        }
    }
    
}
