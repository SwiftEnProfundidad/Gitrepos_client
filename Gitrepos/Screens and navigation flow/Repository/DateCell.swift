//
//  DateCell.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 28/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

class DateCell: UITableViewCell {
    @IBOutlet private weak var lblDate: UILabel!
    
    var viewModel = ViewModel() {
        didSet {
            lblDate.text = viewModel.dateText
        }
    }
}

// MARK: - ViewModel
extension DateCell {
    struct ViewModel {
        var date = Date()
        
        var dateText: String {
            return date.dateText
        }
    }
}
