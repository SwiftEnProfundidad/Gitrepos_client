//
//  CachingController.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 24/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import Foundation

struct CachedValue<T> {
    let value: T
    let isStale: Bool
}

class CachingController {
    let cacheController = FileSystemCacheController()
    
    func fetchValue<V: Decodable>(for url: URL) -> CachedValue<V>? {
        guard let storedValue: StoredValue<V> = cacheController.fetchValue(for: url) else {
            return nil
        }
        let expirationTime: TimeInterval = 60 * 10
        let isStale = Date().timeIntervalSince(storedValue.date) > expirationTime
        return CachedValue(value: storedValue.value, isStale: isStale)
    }
    
    func store<V: Encodable>(value: V, for url: URL) {
        func reduceCacheSizeIfNeeded() {
            let maximumCacheSize: Bytes = 1024 * 1024 * 10
            guard cacheController.cacheSize > maximumCacheSize else {
                return
            }
            let sortedEntries = cacheController.entries.sorted(by: { $0.date < $1.date })
            for entry in sortedEntries {
                guard cacheController.cacheSize > maximumCacheSize else {
                    break
                }
                cacheController.removeValue(for: entry.url)
            }
        }
        
        cacheController.store(value: value, for: url)
        reduceCacheSizeIfNeeded()
    }
}

// MARK: - StoredEntry

struct StoredEntry {
    let url: URL
    let date: Date
    let size: Bytes
}
