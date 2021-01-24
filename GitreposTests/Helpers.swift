//
//  Helpers.swift
//  GitreposTests
//
//  Created by Juan Carlos Merlos Albarracin on 24/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import XCTest
@testable import Gitrepos

extension XCTestCase {
    func verify<T>(url: String, in fetchableValue: FetchableValue<T>, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(url, fetchableValue.url.absoluteString, file: file, line: line)
        if case .fetched(_) = fetchableValue.value {
            XCTFail("A decoder FetchableValue should have an unfetched value", file: file, line: line)
        }
    }
    
    func openJsonFile<Model: Decodable>(withName name: String) -> Model? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: name, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            XCTFail("Could not load the data from the file")
            return nil
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let model = try? decoder.decode(Model.self, from: data) else {
            XCTFail("Could no decode the JSON data")
            return nil
        }
        return model
    }
}


