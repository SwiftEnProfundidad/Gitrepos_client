//
//  EditProfileViewController.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 4/2/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, Stateful, UsersCoordinated {
    
    @IBOutlet private weak var editProfileTableView: UITableView!
    @IBOutlet private weak var buttonSave: UIBarButtonItem!
    @IBOutlet private weak var controllerScrolling: TableViewScrollingController!
    
    private var dataSource: EditProfileTableViewDataSource?
    private var keyboardObservers: [NSObjectProtocol] = []
    
    var stateController: StateController?
    weak var usersCoordinator: UsersFlowCoordinator?
}

// MARK: UIViewController

extension EditProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        guard let user: User = Loader.loadDataFromJSONFile(withName: "User") else {
            return
        }
        let dataSource = EditProfileTableViewDataSource(user: user)
        self.dataSource = dataSource
        editProfileTableView.dataSource = dataSource
        editProfileTableView.delegate = self
        editProfileTableView.reloadData()
    }
}

// MARK: UITableViewDelegate

extension EditProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch cell {
            case let cell as AvatarInputCell: cell.delegate = self
            case let cell as DetailInputCell: cell.delegate = self
            case let cell as BioInputCell: cell.delegate = self
            default: break
        }
    }
}

// MARK: ScrollingDelegate

extension EditProfileViewController: ScrollingDelegate {
    //    func activeViewDidChange(_ view: UIView?) {
    //        guard let activeView = view else {
    //            controllerScrolling.activeViewFrame = nil
    //            return
    //        }
    //        let frame = activeView.convert(activeView.bounds, to: editProfileTableView)
    //        controllerScrolling.activeViewFrame = frame
    //    }
    
    func activeViewDidChange(_ view: UIView?) {
        let activeRect: CGRect
        
        guard let activeView = view else {
            controllerScrolling.activeViewFrame = nil
            return
        }
        if let textView = activeView as? UITextView {
            activeRect = textView.caretRect(for: textView.endOfDocument)
        } else {
            activeRect = activeView.bounds
        }
        editProfileTableView.performBatchUpdates({
            let frame = activeView.convert(activeRect, to: editProfileTableView)
            controllerScrolling.activeViewFrame = frame
        }, completion: nil)
    }
}

// MARK: AvatarInputCellDelegate

extension EditProfileViewController: AvatarInputCellDelegate {
    func photoCellDidEditPhoto(	_ cell: AvatarInputCell) {
        usersCoordinator?.viewControllerDidEditPhoto(self)
    }
}

// MARK: - CoordinatorDelegate

extension EditProfileViewController: UsersCoordinatorDelegate {
    func coordinatorDidPick(image: UIImage) {
        dataSource?.set(avatar: image)
        editProfileTableView.reloadData()
    }
}


// MARK: DetailInputCellDelegate

extension EditProfileViewController: DetailInputCellDelegate {
    func inputCell(_ cell: DetailInputCell, didChange text: String) {
        guard let dataSource = dataSource,
              let index = editProfileTableView.indexPath(for: cell)?.row else {
            return
        }
        dataSource.set(text: text, at: index)
        buttonSave.isEnabled = dataSource.isDataValid
        editProfileTableView.performBatchUpdates({
            cell.configure(with: dataSource.row(at: index))
        }, completion: nil)
    }
    
    func inputCellDidReturn(_ cell: DetailInputCell) {
        editProfileTableView.showCursorInCell(after: cell)
    }
}

// MARK: BioInputCellDelegate

extension EditProfileViewController: BioInputCellDelegate {
    func bioCell(_ cell: BioInputCell, didChange text: String) {
        UIView.setAnimationsEnabled(false)
        editProfileTableView.performBatchUpdates({
            guard let index = editProfileTableView.indexPath(for: cell)?.row else {
                return
            }
            dataSource?.set(text: text, at: index)
        }, completion: { _ in
            UIView.setAnimationsEnabled(true)
        })
    }
}

// MARK: Private

private extension EditProfileViewController {
    func registerForKeyboardNotifications() {
        let defaultCenter = NotificationCenter.default
        let keyboardDidShowObserver = defaultCenter.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: nil, using: { [weak self] notification in
            self?.controllerScrolling.keyboardFrame = notification.keyboardFrame
        })
        
        let keyboardDidHideObserver = defaultCenter.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: nil, using: { [weak self] notification in
            self?.controllerScrolling.keyboardFrame = nil
        })
        keyboardObservers = [keyboardDidShowObserver, keyboardDidHideObserver]
    }
}

// MARK: - Row

extension EditProfileViewController {
    enum Row {
        case avatar(UIImage)
        case name(String)
        case blog(String)
        case company(String)
        case location(String)
        case bio(String)
        
        var cellType: UITableViewCell.Type {
            switch self {
                case .avatar: return AvatarInputCell.self
                case .name, .blog, .company, .location: return DetailInputCell.self
                case .bio: return BioInputCell.self
            }
        }
        
        var separator: UITableViewCell.SeparatorType {
            switch self {
                case .avatar: return .none
                case .name, .blog, .company, .location, .bio: return .insetted(24.0)
            }
        }
        
        var label: String {
            switch self {
                case .name: return "Name"
                case .blog: return "Blog"
                case .company: return "Company"
                case .location: return "Location"
                case .bio: return "Bio"
                case .avatar: assertionFailure("The avatar has no label")
                    return ""
            }
        }
        
        var placeHolder: String {
            switch self {
                case .name: return "Name or nickname"
                case .blog: return "example.com"
                case .company: return "Company name"
                case .location: return "City"
                case .bio: return "Tell us a bit about yourself"
                case .avatar:
                    assertionFailure("The avatar has no placeholder")
                    return ""
            }
        }
        
        var errorMessage: String {
            switch self {
                case .name, .company, .location: return ""
                case .blog: return "The URL is not valid"
                case .bio:
                    assertionFailure("The bio has no error message")
                    return ""
                case .avatar:
                    assertionFailure("The avatar has no error message")
                    return ""
            }
        }
    }
}

// MARK: - Notification

extension Notification {
    var keyboardFrame: CGRect {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? CGRect.zero
    }
}
