//
//  GitreposTests.swift
//  GitreposTests
//
//  Created by Juan Carlos Merlos Albarracin on 22/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import XCTest
@testable import Gitrepos

class URLTest: XCTestCase {

    // MARK: -  Set Up & Tear Down
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testInitFromTemplate() {
        let template = "https://api.github.com/users/octocat/starred{/owner}{/repo}"
        guard let url = URL(template: template) else {
            XCTFail("The initialization failed")
            return
        }
        XCTAssertEqual(url.absoluteString, "https://api.github.com/users/octocat/starred")
    }
}
