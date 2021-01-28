//
//  RepositoryCell.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 28/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit
import Foundation

class RepositoryCell: UITableViewCell {
    
    @IBOutlet private weak var labelName: UILabel!
    @IBOutlet private weak var labelUsername: UILabel!
    @IBOutlet private weak var labelDescription: UILabel!
    @IBOutlet private weak var labelStar: UILabel!
    @IBOutlet private weak var labelForks: UILabel!
    @IBOutlet private weak var labelLanguage: UILabel!
    @IBOutlet private weak var imageViewLanguage: UIImageView!
    @IBOutlet private weak var labelDate: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    var viewModel = ViewModel() {
        didSet {
            labelName.text = viewModel.name
            labelUsername.text = viewModel.username
            labelDescription.text = viewModel.description
            labelDescription.isHidden = viewModel.description.isEmpty
            labelLanguage.text = viewModel.language
            imageViewLanguage.isHidden = viewModel.language.isEmpty
            avatarImage.image = viewModel.avatar
            labelForks.text = viewModel.forksText
            labelStar.text = viewModel.starsText
            labelDate.text = viewModel.dateText
        }
    }
}

// MARK: - ViewModel

extension RepositoryCell {
    struct ViewModel {
        var name = ""
        var username = ""
        var description = ""
        var language = ""
        var starsCount = 0
        var forksCount = 0
        var avatar = UIImage()
        var date = Date()
        
        var starsText: String {
            return "\(starsCount)"
        }
        
        var forksText: String {
            return "\(forksCount)"
        }
        
        var dateText: String {
            return date.dateText
        }
    }
}

