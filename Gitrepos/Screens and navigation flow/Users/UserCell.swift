//
//  UserCell.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 27/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

/// UserCell se encarga de la decisión de diseño
class UserCell: UITableViewCell {

    @IBOutlet private weak var imageAvatar: UIImageView!
    @IBOutlet private weak var nameFull: UILabel!
    @IBOutlet private weak var nameUser: UILabel!
    @IBOutlet private weak var labelLocation: UILabel!
    @IBOutlet private weak var labelBio: UILabel!
    @IBOutlet private weak var viewStack: UIStackView!
    
    var viewModel = ViewModel() {
        didSet {
            nameFull.text = viewModel.name
            nameUser.text = viewModel.username
            labelLocation.text = viewModel.location
            labelLocation.isHidden = viewModel.location.isEmpty
            viewStack.isHidden = viewModel.location.isEmpty
            imageAvatar.image = viewModel.avatar
            labelBio.text = viewModel.bio
            labelBio.isHidden = viewModel.bio.isEmpty
        }
    }
    
}

/// Especificamos qué datos requiere nuestra celda.
/// Aquí nos preocupamos por lo que contiene nuestra
/// celda, no por los datos en nuestra aplicación.
/// El view model. lo ponemos aquí, ya que pertenece
/// a la vista y es independiente de los tipos modelo.
extension UserCell {
    struct ViewModel {
        var name = ""
        var username = ""
        var location = ""
        var bio = ""
        var avatar = UIImage()
    }
}

