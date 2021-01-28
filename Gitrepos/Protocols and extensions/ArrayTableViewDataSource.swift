//
//  ArrayTableViewDataSource.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 28/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

protocol ArrayTableViewDataSource: class {
    associatedtype ModelType
    associatedtype ViewModel
    associatedtype Cell: UITableViewCell
    var dataOrganizer: ArrayDataSourceOrganizer<ModelType> { get }
    var viewModelCache: [IndexPath: ViewModel] { get set }
    func viewModel(for value: ModelType) -> ViewModel
    func configure(cell: Cell, with viewModel: ViewModel)
}

// MARK: - Protocol Extension

extension ArrayTableViewDataSource {
    var rowsCount: Int {
        return dataOrganizer.rowsCount
    }
    
    func cell(from tableView: UITableView, for indexPath: IndexPath) -> Cell {
        func extractViewModel(at indexPath: IndexPath) -> ViewModel {
            let viewModel: ViewModel
            if let cachedViewModel = viewModelCache[indexPath] {
                viewModel = cachedViewModel
            } else {
                let value = dataOrganizer[indexPath]
                viewModel = self.viewModel(for: value)
            }
            return viewModel
        }
        let cell: Cell = tableView.dequeueReusableCell(for: indexPath)
        configure(cell: cell, with: extractViewModel(at: indexPath) )
        return cell
    }
}

// MARK: - ArrayDataSourceOrganizer

struct ArrayDataSourceOrganizer<ModelType> {
    let items: [ModelType]
    
    var rowsCount: Int {
        return items.count
    }
    
    subscript(indexPath: IndexPath) -> ModelType {
        return items[indexPath.row]
    }
}

