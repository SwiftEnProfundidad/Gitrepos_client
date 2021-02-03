//
//  AvatarCell.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 2/2/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

class AvatarCell: UITableViewCell {
    
    @IBOutlet private weak var avatarImgView: UIImageView!
    var avatar = UIImage() {
        didSet {
            avatarImgView.image = avatar
        }
    }
}
