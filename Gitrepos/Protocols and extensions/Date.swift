//
//  Date.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 28/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import Foundation

extension Date {
    var dateText: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        let formatted = formatter.string(from: self)
        return "Updated on " + formatted
    }
}
