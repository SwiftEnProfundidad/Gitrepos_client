//
//  StateController.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 18/2/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import Foundation

class StateController {
    var user: User? {
        guard var user: User = Loader.loadDataFromJSONFile(withName: "User"),
              let repositories: [Repository] = Loader.loadDataFromJSONFile(withName: "Repositories") else {
            return nil
        }
        user.stars.value = .fetched(value: repositories)
        return user
    }
    
    var users: [User] {
        return Loader.loadDataFromJSONFile(withName: "Users") ?? []
    }
    
    var repository: Repository? {
        guard var repository: Repository = Loader.loadDataFromJSONFile(withName: "Repository") else {
            return nil
        }
        let readMeURL = URL(string: "https://github.com/octokit/octokit.rb/blob/master/README.md")!
        repository.readMe = FetchableValue(url: readMeURL, value: .fetched(value: ""))
        return repository
    }
    
    var repositories: [Repository] {
        return Loader.loadDataFromJSONFile(withName: "Repositories") ?? []
    }
}
