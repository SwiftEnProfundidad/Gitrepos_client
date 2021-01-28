//
//  ArrayDataSourceOrganizerTests.swift
//  GitreposTests
//
//  Created by Juan Carlos Merlos Albarracin on 28/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import XCTest
@testable import Gitrepos

class ArrayDataSourceOrganizerTests: XCTestCase {
    func testRows() {
        let organizer = ArrayDataSourceOrganizer(items: [1, 2, 3, 5, 7])
        XCTAssertEqual(organizer.rowsCount, 5)
        let indexPath = IndexPath(row: 4, section: 0)
        XCTAssertEqual(organizer[indexPath], 7)
    }
}
