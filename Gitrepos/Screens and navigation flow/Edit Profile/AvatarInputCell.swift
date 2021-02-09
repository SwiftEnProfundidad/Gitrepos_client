//
//  AvatarInputCell.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 4/2/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

class AvatarInputCell: UITableViewCell {
    @IBOutlet private weak var imageViewAvatar: UIImageView!
    
    var avatar = UIImage() {
        didSet {
            imageViewAvatar.image = avatar
        }
    }
}

