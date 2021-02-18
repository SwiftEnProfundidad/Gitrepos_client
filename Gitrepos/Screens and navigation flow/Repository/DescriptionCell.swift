//
//  DescriptionCell.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 28/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

class DescriptionCell: UITableViewCell {    
    @IBOutlet private weak var descpLabel: UILabel!
    
    var descriptionText: String = "" {
        didSet {
            descpLabel.text = descriptionText
        }
    }
}
