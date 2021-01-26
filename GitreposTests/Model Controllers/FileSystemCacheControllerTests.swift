//
//  FileSystemCacheControllerTests.swift
//  GitreposTests
//
//  Created by Juan Carlos Merlos Albarracin on 26/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import XCTest
@testable import Gitrepos

class FileSystemCacheControllerTests: XCTestCase {
    func testFileURL() {
        let testURL = "https://api.github.com/users/octocat/starred"
        let baseURL = "/directory"
        let fileURL = URL(string: testURL)!.fileUrl(withBaseURL: URL(fileURLWithPath: baseURL))
        XCTAssertNotNil(fileURL)
        XCTAssertEqual(fileURL?.absoluteString, "file:///directory/https%253A%252F%252Fapi%252Egithub%252Ecom%252Fusers%252Foctocat%252Fstarred.json")
    }
}
