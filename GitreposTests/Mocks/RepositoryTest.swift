//
//  RepositoryTest.swift
//  GitreposTests
//
//  Created by Juan Carlos Merlos Albarracin on 24/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import XCTest
@testable import Gitrepos

class RepositoryTest: XCTestCase {
    
    func testRepositoryDecoding() {
        let repository: Repository = openJsonFile(withName: "Repository")!
        XCTAssertEqual(repository.id.value, 1296269)
        XCTAssertEqual(repository.name, "Hello-World")
        XCTAssertEqual(repository.isFork, true)
        XCTAssertEqual(repository.forksCount, 9)
        XCTAssertEqual(repository.owner.id.value, 1)
        XCTAssertEqual(repository.description, "This your first repo!")
        XCTAssertNil(repository.language)
        XCTAssertNil(repository.parent)
    }
    
}
