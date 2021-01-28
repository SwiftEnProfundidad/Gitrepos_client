//
//  RepositoryCellTests.swift
//  GitreposTests
//
//  Created by Juan Carlos Merlos Albarracin on 28/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import XCTest
@testable import Gitrepos

class RepositoryCellTests: XCTestCase {

    func testViewModel() {
        var viewModel = RepositoryCell.ViewModel()
        viewModel.starsCount = 2
        viewModel.forksCount = 3
        XCTAssertEqual(viewModel.starsText, "2")
        XCTAssertEqual(viewModel.forksText, "3")
    }

}
