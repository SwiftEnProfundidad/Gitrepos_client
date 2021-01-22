//
//  User.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 22/1/21.
//

import UIKit

struct User {
    let login: String
    let id: Int
    let avatar: UIImage
    // Con las colecciones, sí
    // podemos hacer recursividad
    var repositories: [Repository]?
    var stars: [Repository]?
    var followers: [User]?
    var followed: Bool?
}
