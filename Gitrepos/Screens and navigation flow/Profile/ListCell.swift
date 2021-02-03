//
//  ListCell.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 2/2/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    @IBOutlet private weak var labelCount: PaddedLabel!
    @IBOutlet private weak var labelSection: UILabel!
    
    var viewModel = ViewModel() {
        didSet{
            labelCount.text = viewModel.countText
            labelSection.text = viewModel.name
        }
    }
}

// MARK: - ViewModel

extension ListCell {
    struct ViewModel {
        var count = 0
        var name = ""
        
        var countText: String {
            return "\(count)"
        }
    }
}
