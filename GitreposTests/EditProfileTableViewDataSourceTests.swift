//
//  EditProfileTableViewDataSourceTests.swift
//  GitreposTests
//
//  Created by Juan Carlos Merlos Albarracin on 11/2/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import XCTest
@testable import Gitrepos

class EditProfileTableViewDataSourceTests: XCTestCase {
    
    func testRows() {
        let user: User = openJsonFile(withName: "User")!
        let organizer = EditProfileTableViewDataSource.DataOrganizer(user: user)
        XCTAssertEqual(organizer.rowsCount, 6)
    }
    
    func testFields() {
        let user: User = openJsonFile(withName: "User")!
        let organizer = EditProfileTableViewDataSource.DataOrganizer(user: user)
        XCTAssert(organizer.row(at: 0).isValueEqual(to: #imageLiteral(resourceName: "Avatar")))
        XCTAssert(organizer.row(at: 1).isValueEqual(to: "monalisa octocat"))
        XCTAssert(organizer.row(at: 2).isValueEqual(to: "https://github.com/blog"))
        XCTAssert(organizer.row(at: 3).isValueEqual(to: "GitHub"))
        XCTAssert(organizer.row(at: 4).isValueEqual(to: "San Francisco"))
        XCTAssert(organizer.row(at: 5).isValueEqual(to: "There once was..."))
    }
    
    func testSetters() {
        let user: User = openJsonFile(withName: "User")!
        var organizer = EditProfileTableViewDataSource.DataOrganizer(user: user)
        organizer.set(text: "aaa", at: 3)
        XCTAssert(organizer.row(at: 3).isValueEqual(to: "aaa"))
    }
    
    func testIsDataValid() {
        let user: User = openJsonFile(withName: "User")!
        var organizer = EditProfileTableViewDataSource.DataOrganizer(user: user)
        XCTAssert(organizer.isDataValid)
        organizer.set(text: "https: // github .com/ blog", at: 2)
        XCTAssertFalse(organizer.isDataValid)
    }
}

private extension EditProfileViewController.Row {
    func isValueEqual(to value: Any) -> Bool {
        switch self {
            case let .avatar(image): return image == value as? UIImage
            case let .name(text), let .blog(text), let .company(text), let .location(text), let .bio(text): return text == value as? String
        }
    }
}
