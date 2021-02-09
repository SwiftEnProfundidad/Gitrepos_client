//
//  BioInputCell.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 4/2/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

class BioInputCell: UITableViewCell, UITextViewDelegate {
    @IBOutlet private weak var textView: UITextView! {
        didSet {
            textView.textContainerInset = UIEdgeInsets.zero
            textView.textContainer.lineFragmentPadding = 0
            textView.delegate = self
        }
    }
    
    var bioText = "" {
        didSet {
            textView.text = bioText
        }
    }
}
