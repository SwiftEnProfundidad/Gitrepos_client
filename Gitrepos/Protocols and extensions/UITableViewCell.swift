//
//  UITableViewCell.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 3/2/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

extension UITableViewCell {
    enum SeparatorType {
        case none
        case insetted(CGFloat)
    }
    
    var separator: SeparatorType {
        set {
            let left: CGFloat = {
                switch newValue {
                    case .none:
                        return bounds.size.width
                    case .insetted(let value): return value
                }
            }()
            separatorInset = UIEdgeInsets(top: 0, left: left, bottom: 0, right: 0)
        }
        get {
            assertionFailure("This method only returns a default value")
            return .none
        }
    }
}
