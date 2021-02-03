//
//  PaddedLabel.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 2/2/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

@IBDesignable
class PaddedLabel: UILabel {
    
    @IBInspectable var verticalPadding: CGFloat = 0
    @IBInspectable var horizontalPadding: CGFloat = 0
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + horizontalPadding, height: size.height + verticalPadding)
    }
}
