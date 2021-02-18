//
//  User+EditProfileViewController.Row.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 4/2/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import Foundation

extension User {
    subscript(row: EditProfileViewController.Row) -> EditProfileViewController.Row {
        let details = self.details.fetchedValue
        switch row {
            case .avatar: return .avatar(#imageLiteral(resourceName: "Avatar"))
            case .name: return .name(details?.name ?? "")
            case .blog: return .blog(details?.blog?.absoluteString ?? "")
            case .company: return .company(details?.company ?? "")
            case .location: return .location(details?.location ?? "")
            case .bio: return .bio(details?.bio ?? "")
        }
    }
}
