//
//  FetchableValueTests.swift
//  GitreposTests
//
//  Created by Juan Carlos Merlos Albarracin on 24/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import XCTest
@testable import Gitrepos

class FetchableValueTests: XCTestCase {
    
    // MARK: -  Set Up & Tear Down
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCorruptedDataError() {
        let json = "{ \"avatar_url\": \"\" }"
            .data(using: .utf8)!
        XCTAssertThrowsError(try JSONDecoder().decode(TestStruct.self, from: json))
    }
    
}

private extension FetchableValueTests {
    struct TestStruct: Decodable {
        let testProperty: FetchableValue<Bool>
        
        enum CodingKeys: String, CodingKey {
            case avatar_url
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            testProperty = try container.decode(FetchableValue.self, forKey: .avatar_url)
        }
    }
}
