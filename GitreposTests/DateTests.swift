//
//  DateTests.swift
//  GitreposTests
//
//  Created by Juan Carlos Merlos Albarracin on 28/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import XCTest
@testable import Gitrepos

class DateTests: XCTestCase {

    func testFormat() {
        let date = Date(string: "03/11/2017 12:00:00")!
        XCTAssertEqual(date.dateText, "Updated on November 3, 2017")
    }
}
