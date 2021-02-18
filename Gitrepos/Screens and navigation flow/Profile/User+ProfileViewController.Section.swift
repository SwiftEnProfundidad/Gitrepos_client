//
//  User+ProfileViewController.Section.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 3/2/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import Foundation

extension User {
    subscript(row: ProfileViewController.Section.SummaryRow) -> Any? {
        let details = self.details.fetchedValue
        switch row {
            case .bio: return details?.bio
            case .name: return details?.name
            case .username: return login
            case .avatar: return avatar
        }
    }
    
    subscript(row: ProfileViewController.Section.DetailRow) -> String {
        let details = self.details.fetchedValue
        let text: String? = {
            switch row {
                case .email: return details?.email
                case .company: return details?.company
                case .location: return details?.location
                case .blog: return details?.blog?.absoluteString
            }
        }()
        return text ?? ""
    }
    
    subscript(row: ProfileViewController.Section.ListRow) -> Int {
        let details = self.details.fetchedValue
        let count: Int? = {
            switch row {
                case .repositories: return details?.publicRepositoriesCount
                case .stars: return stars.fetchedValue?.count
                case .followers: return details?.followersCount
                case .following: return details?.followingCount
            }
        }()
        return count ?? 0
    }
}

