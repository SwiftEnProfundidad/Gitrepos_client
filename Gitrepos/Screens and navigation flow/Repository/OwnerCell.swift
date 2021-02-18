//
//  OwnerCell.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 28/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

class OwnerCell: UITableViewCell {
    @IBOutlet private weak var imageViewAvatar: UIImageView!
    @IBOutlet private weak var labelName: UILabel!
    @IBOutlet private weak var labelUsername: UILabel!
    
    var viewModel = ViewModel() {
        didSet {
            imageViewAvatar.image = viewModel.avatar
            labelName.text = viewModel.name
            labelUsername.text = viewModel.username
        }
    }
}

// MARK: - ViewModel

extension OwnerCell {
    struct ViewModel {
        var avatar = UIImage()
        var name = ""
        var username = ""
    }
}

