//
//  CountersCell.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 28/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

class CountersCell: UITableViewCell {
    @IBOutlet private weak var labelStars: UILabel!
    @IBOutlet private weak var labelForks: UILabel!
    
    var viewModel = ViewModel() {
        didSet {
            labelStars.text = viewModel.starsText
            labelForks.text = viewModel.forksText
        }
    }
}

// MARK: - ViewModel

extension CountersCell {
    struct ViewModel {
        var starsCount = 0
        var forksCount = 0
        
        var starsText: String {
            return "\(starsCount)"
        }
        
        var forksText: String {
            return "\(forksCount)"
        }
    }
}
