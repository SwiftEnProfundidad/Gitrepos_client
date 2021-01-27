//
//  UINavigationBar.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 27/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

extension UINavigationBar {
    static func setCustomAppearance() {
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = .mediumCarmine
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
