//
//  Repository.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 22/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import Foundation

/// Como no podemos hacer recursividad en Swift, añadimos un protocolo
/// para hacer referencia al propio repositorio, es decir, no podemos
/// hacer una propiedad: `let parent: Repository` que nos hace falta
/// para saber cual es el `parent` del repositorio al que apuntamos.
/// `Lección 1.7: iOS Architect`.
protocol RepositoryType { }

struct Repository: RepositoryType {
    let id: Int
    let name: String
    let isFork: Bool
    let forksCount: Int
    let stargazersCount: Int
    let owner: User
    let updateDate: Date
    let description: String?
    let language: String?
    let parent: RepositoryType?
    var readMe: String?
    var starred: Bool?
}

