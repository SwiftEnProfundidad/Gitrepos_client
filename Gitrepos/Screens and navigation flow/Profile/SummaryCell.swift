//
//  SummaryCell.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 2/2/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

class SummaryCell: UITableViewCell {
    @IBOutlet private weak var summaryLabel: UILabel!
    @IBOutlet private weak var constraintBottom: NSLayoutConstraint!
    
    var viewModel: ViewModel = ViewModel() {
        didSet {
            summaryLabel.text = viewModel.text
            let style = viewModel.style
            summaryLabel.textColor = style.color
            summaryLabel.textAlignment = style.alignment
            summaryLabel.font = UIFont.systemFont(ofSize: style.size, weight: style.weight)
            constraintBottom.constant = style.margin
        }
    }
}

// MARK: - ViewModel

extension SummaryCell {
    struct ViewModel {
        struct Style {
            var margin: CGFloat = 0
            var size: CGFloat = 0
            var weight = UIFont.Weight.regular
            var color = UIColor.clear
            var alignment = NSTextAlignment.left
        }
        
        var text = ""
        var style = Style()
    }
}
