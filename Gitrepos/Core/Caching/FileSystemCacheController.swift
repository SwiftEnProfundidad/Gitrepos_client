//
//  PersistenceController.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 24/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import Foundation

typealias Bytes = CLongLong

protocol FileManaging {
    func removeItem(at URL: URL) throws
    func contentsOfDirectory(at url: URL, includingPropertiesForKeys keys: [URLResourceKey]?, options mask: FileManager.DirectoryEnumerationOptions) throws -> [URL]
    func createFile(atPath path: String, contents data: Data?, attributes attr: [FileAttributeKey : Any]?) -> Bool
    func contents(atPath path: String) -> Data?
    func attributesOfItem(atPath path: String) throws -> [FileAttributeKey : Any]
}

extension FileManager: FileManaging { }

/// Después de analizar el código en FileSystemCacheController, la conclusión es:
/// el comportamiento obtiene o almacena información en el sistema de archivo y la
/// lógica expresa cómo almacenamos o leemos información en el directorio de caché
class FileSystemCacheController {
//    private let gitHubDirectory = GitHubDirectory(
//        iOSCachesDirectoryURL: FileManager.default
//            .urls(for: .cachesDirectory, in: .userDomainMask)
//            .first!
//    )
    private let gitHubDirectory: GitHubDirectory
    var fileManager: FileManaging = FileManager.default
    
    init(cachesDirectoryURL: URL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!) {
        gitHubDirectory = GitHubDirectory(iOSCachesDirectoryURL: cachesDirectoryURL)
    }
    
}

// MARK: Caching

extension FileSystemCacheController: Caching {
    
    var cacheSize: Bytes {
        let size = (try? fileManager.attributesOfItem(atPath: gitHubDirectory.baseURL.path))?[.size] as? Int
        return size.map(Bytes.init) ?? 0
    }
    
    var entries: [StoredEntry] {
        func fetchEntry(for url: URL) -> StoredEntry? {
            assert(url.isFileURL, "Stored entries can only be created from file URLs")
            guard let attributes = try? fileManager.attributesOfItem(atPath: url.path) else {
                return nil
            }
            return StoredEntry(url: url, attributes: attributes)
        }
        
        func contentsOfDirectory(at url: URL) -> [URL] {
            return (try? fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: [.creationDateKey, .fileSizeKey], options: [])) ?? []
        }
        
        return contentsOfDirectory(at: gitHubDirectory.baseURL)
            .compactMap { fetchEntry(for: $0) }
    }
    
    func store<T: Encodable>(value: T, for url: URL) {
        gitHubDirectory
            .makeStorableData(value: value, url: url)
            .map { storableData in
                _ = fileManager.createFile(atPath: storableData.fileURL.path, contents: storableData.data, attributes: nil)
            }
    }
    
    func fetchValue<T: Decodable>(for url: URL) -> StoredValue<T>? {
        func creationDateForFile(at url: URL) -> Date? {
            assert(url.isFileURL, "The creation date exists only for file URLs")
            guard let attributes = try? fileManager.attributesOfItem(atPath: url.path),
                  let date = attributes[.creationDate] as? Date else {
                return nil
            }
            return date
        }
        
        func extractValue<U: Decodable>(for url: URL) -> U? {
            return fileManager.contents(atPath: url.path).flatMap(GitHubDirectory.value(from:))
        }
        
        guard let fileURL = url.fileUrl(withBaseURL: gitHubDirectory.baseURL) else {
            return nil
        }
        guard let date = creationDateForFile(at: fileURL),
              let value: T = extractValue(for: fileURL) else {
            return nil
        }
        return StoredValue(value: value, date: date)
    }
    
    func removeValue(for url: URL) {
        url.fileUrl(withBaseURL: gitHubDirectory.baseURL)
            .map { try? fileManager.removeItem(at: $0) }
    }
}

/// **************************** Sacamos toda la lógica pura, refeactorizando los métodos de la clase **************************** ///

// MARK: Private

private extension FileSystemCacheController {
    func fileAttributes(for url: URL) -> [FileAttributeKey : Any]? {
        assert(url.isFileURL, "File attributes exist only for file URLs")
        return try? FileManager.default.attributesOfItem(atPath: url.absoluteString)
    }
}

// MARK: - GitHubDirectory

extension FileSystemCacheController {
    struct GitHubDirectory {
        static let name = "githubAPICache"
        let iOSCachesDirectoryURL: URL
        
        var baseURL: URL {
            return iOSCachesDirectoryURL.appendingPathComponent(GitHubDirectory.name)
        }
        
        static func value<V: Decodable>(from data: Data) -> V? {
            return try? JSONDecoder().decode(V.self, from: data)
        }
        
        func makeStorableData<V: Encodable>(value: V, url: URL) -> StorableData? {
            guard let data = try? JSONEncoder().encode(value),
                  let fileURL = url.fileUrl(withBaseURL: baseURL) else {
                return nil
            }
            return StorableData(data: data, fileURL: fileURL)
        }
    }
}

// MARK: StorableData

extension FileSystemCacheController.GitHubDirectory {
    struct StorableData {
        let data: Data
        let fileURL: URL
    }
}

// MARK: - StoredEntry

/// Lógica que está dentro de un tipo de valor, estructura `StoryEntrie`, en lugar de una clase
extension StoredEntry {
    init?(url: URL, attributes: [FileAttributeKey : Any]) {
        guard let date = attributes[.creationDate] as? Date,
              let size = attributes[.size] as? Int else {
            return nil
        }
        self.url = url
        self.date = date
        self.size = Bytes(size)
    }
}

// MARK: - URL

// Lógica
extension URL {
    func fileUrl(withBaseURL baseURL: URL) -> URL? {
        assert(!isFileURL, "A file URL can be created only for a web URL, to avoid double indirection in the encoding")
        guard let percentEscaped = absoluteString.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else {
            return nil
        }
        return baseURL
            .appendingPathComponent(percentEscaped)
            .appendingPathExtension("json")
    }
}
































