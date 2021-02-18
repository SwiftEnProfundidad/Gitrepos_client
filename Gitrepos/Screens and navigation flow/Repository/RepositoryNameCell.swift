//
//  RepositoryNameCell.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 28/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

class RepositoryNameCell: UITableViewCell {    
    @IBOutlet weak var reposNameLbl: UILabel!
    var name: String = "" {
        didSet {
            reposNameLbl.text = name
        }
    }
}
