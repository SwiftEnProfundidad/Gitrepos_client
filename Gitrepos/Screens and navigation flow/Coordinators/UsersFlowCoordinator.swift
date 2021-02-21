//
//  UserFlowCoordinator.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 19/2/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit
import MessageUI

// MARK: Protocols

protocol UsersCoordinatorDelegate: AnyObject {
    func coordinatorDidPick(image: UIImage)
}

// MARK: - UsersFlowCoordinator

class UsersFlowCoordinator: NSObject {
    weak var parent: Coordinator?
    weak var delegate: UsersCoordinatorDelegate?
    
    func profileViewControllerDidSelectedUsers(_ viewController: ProfileViewController) {
        viewController.performSegue(withIdentifier: ProfileViewControllerSegues.showUsers, sender: nil)
    }
    
    func profileViewControllerDidRepositories(_ viewController: ProfileViewController) {
        viewController.performSegue(withIdentifier: ProfileViewControllerSegues.showRepositories, sender: nil)
    }
    
    func profileViewController(_ viewController: ProfileViewController, didSelectEmail email: String) {
        let mailViewController = MFMailComposeViewController()
        mailViewController.setToRecipients([email])
        viewController.show(mailViewController, sender: nil)
    }
    
    func viewControllerDidEditPhoto(_ viewController: UIViewController & UsersCoordinatorDelegate) {
        delegate = viewController
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        viewController.present(imagePickerController, animated: true, completion: nil)
    }
}

// MARK: Coordinator

extension UsersFlowCoordinator: Coordinator {
    func configure(viewController: UIViewController) {
        parent?.configure(viewController: viewController)
    }
}

// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension UsersFlowCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            delegate?.coordinatorDidPick(image: image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - ProfileViewControllerSegues

extension UsersFlowCoordinator {
    struct ProfileViewControllerSegues {
        static let showUsers = "ShowUsers"
        static let showRepositories = "ShowRepositories"
    }
}
