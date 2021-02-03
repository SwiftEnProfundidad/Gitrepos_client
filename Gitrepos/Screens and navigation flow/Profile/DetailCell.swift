//
//  DetailCell.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 2/2/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {
    @IBOutlet private weak var imageViewIcon: UIImageView!
    @IBOutlet private weak var detailLabel: UILabel!
    
    var viewModel: ViewModel = ViewModel() {
        didSet {
            imageViewIcon.image = viewModel.icon
            detailLabel.text = viewModel.text
            detailLabel.textColor = viewModel.active ? .mediumCarmine : .cork
        }
    }
}

// MARK: - ViewModel

extension DetailCell {
    struct ViewModel {
        var icon: UIImage = UIImage()
        var text: String = ""
        var active: Bool = false
    }
}

