//
//  Paddable.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 4/2/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

protocol Paddable {
    var verticalPadding: CGFloat { get set }
    var horizontalPadding: CGFloat { get set }
}

extension Paddable {
    func pad(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width + horizontalPadding, height: size.height + verticalPadding)
    }
}

@IBDesignable
class PaddedLabel: UILabel, Paddable {
    @IBInspectable var verticalPadding: CGFloat = 0
    @IBInspectable var horizontalPadding: CGFloat = 0
    
    override var intrinsicContentSize: CGSize {
        return pad(super.intrinsicContentSize)
    }
}

@IBDesignable
class PaddedButton: UIButton, Paddable {
    @IBInspectable var verticalPadding: CGFloat = 0
    @IBInspectable var horizontalPadding: CGFloat = 0
    
    override var intrinsicContentSize: CGSize {
        return pad(super.intrinsicContentSize)
    }
}
