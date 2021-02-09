//
//  DetailInputCell.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 4/2/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

class DetailInputCell: UITableViewCell {
    @IBOutlet private weak var fieldLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var errorMessageLabel: UILabel!
    
    var viewModel = ViewModel() {
        didSet {
            fieldLabel.text = viewModel.label
            textField.text = viewModel.text
            textField.placeholder = viewModel.placeholder
            errorMessageLabel.text = viewModel.errorMessage
            errorMessageLabel.isHidden = viewModel.isValid
        }
    }
}

extension DetailInputCell {
    struct ViewModel {
        var label = ""
        var text = ""
        var placeholder = ""
        var errorMessage = ""
        var isValid = true
    }
}
