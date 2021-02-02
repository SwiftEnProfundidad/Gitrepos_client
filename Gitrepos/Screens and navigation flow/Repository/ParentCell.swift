//
//  ParentCell.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 29/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

class ParentCell: UITableViewCell {
    @IBOutlet private weak var parentLabel: UILabel!
    
    var parentName: String = "" {
        didSet {
            parentLabel.text = parentName
        }
    }
}
