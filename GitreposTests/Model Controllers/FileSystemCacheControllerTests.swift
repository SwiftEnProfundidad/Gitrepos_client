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
    let url = URL(string:"www.test.com")!
    let cachesDirectoryURL = URL(fileURLWithPath: "/caches")
    var controller: FileSystemCacheController!
    var mock: MockFileManager!
    
    override func setUp() {
        controller = FileSystemCacheController(cachesDirectoryURL: cachesDirectoryURL)
        mock = MockFileManager()
        controller.fileManager = mock
    }
    
    func testFileURL() {
        let testURL = "https://api.github.com/users/octocat/starred"
        let baseURL = "/directory"
        let fileURL = URL(string: testURL)!.fileUrl(withBaseURL: URL(fileURLWithPath: baseURL))
        XCTAssertNotNil(fileURL)
        XCTAssertEqual(fileURL?.absoluteString, "file:///directory/https%253A%252F%252Fapi%252Egithub%252Ecom%252Fusers%252Foctocat%252Fstarred.json")
    }
    
    func testStoringValue() {
        let gitHubDirectory = FileSystemCacheController.GitHubDirectory(iOSCachesDirectoryURL: cachesDirectoryURL)
        let path = url.fileUrl(withBaseURL: gitHubDirectory.baseURL)!.path
        controller.store(value: CodableStruct.testValue, for: url)
        XCTAssertNotNil(mock.storage[path])
    }
    
    func testRemovingValue() {
        controller.store(value: CodableStruct.testValue, for: url)
        controller.removeValue(for: URL(string:"www.test.com")!)
        XCTAssert(mock.storage.isEmpty)
    }
    
    func testFechingValue() {
        controller.store(value: CodableStruct.testValue, for: url)
        let fetchValue: StoredValue<CodableStruct>? = controller.fetchValue(for: url)
        XCTAssertNotNil(fetchValue)
    }
    
    func testEntries() {
        XCTAssertEqual(controller.entries.count, 1)
    }
    
    func testCachedSize() {
        XCTAssertEqual(controller.cacheSize, Bytes(100))
    }
}

// MARK: - MockCacheManager

class MockFileManager {
    var storage: [String : Data] = [:]
}


extension MockFileManager: FileManaging {
    func removeItem(at URL: URL) throws {
        storage[URL.path] = nil
    }
    
    func contentsOfDirectory(at url: URL, includingPropertiesForKeys keys: [URLResourceKey]?, options mask: FileManager.DirectoryEnumerationOptions) throws -> [URL] {
        return [url]
    }
    
    func createFile(atPath path: String, contents data: Data?, attributes attr: [FileAttributeKey : Any]? = nil) -> Bool {
        storage[path] = data!
        return true
    }
    
    func contents(atPath path: String) -> Data? {
        return storage[path]
    }
    
    func attributesOfItem(atPath path: String) throws -> [FileAttributeKey : Any] {
        return [FileAttributeKey.creationDate: Date(), FileAttributeKey.size: 100]
    }
    
    
}
