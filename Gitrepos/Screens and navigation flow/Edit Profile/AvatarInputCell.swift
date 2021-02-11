//
//  AvatarInputCell.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 4/2/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

protocol AvatarInputCellDelegate: AnyObject {
    func photoCellDidEditPhoto(_ cell: AvatarInputCell)
}


class AvatarInputCell: UITableViewCell {
    @IBOutlet private weak var imageViewAvatar: UIImageView!
    weak var delegate: AvatarInputCellDelegate?

    var avatar = UIImage() {
        didSet {
            imageViewAvatar.image = avatar
        }
    }
    
    @IBAction func avatarChange(_ sender: Any) {
        delegate?.photoCellDidEditPhoto(self)
    }
}

