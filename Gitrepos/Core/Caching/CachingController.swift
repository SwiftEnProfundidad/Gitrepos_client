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

/// **************************** Dejamo todo la parte de comportamiento en la clase **************************** ///

class CachingController {
    let cacheController = FileSystemCacheController()
    
    func fetchValue<V: Decodable>(for url: URL) -> CachedValue<V>? {
        let storedValue: StoredValue<V>? = cacheController.fetchValue(for: url)
        return storedValue.map { CachingPolicy.cachedValue(from: $0, withCurrentDate: Date()) }
    }
    
    func store<V: Encodable>(value: V, for url: URL) {
        func reduceCacheSizeIfNeeded() {
            let entries = cacheController.entries
            guard CachingPolicy.isCacheSizeOverLimit(cacheSize: cacheController.cacheSize) else {
                return
            }
            for entry in CachingPolicy.entriesToRemove(from: entries) {
                cacheController.removeValue(for: entry.url)
            }
        }
        
        cacheController.store(value: value, for: url)
        reduceCacheSizeIfNeeded()
    }
    
    
}

// MARK: - StoredValue
struct StoredValue<T> {
    let value: T
    let date: Date
}

// MARK: - StoredEntry
struct StoredEntry {
    let url: URL
    let date: Date
    let size: Bytes
}

/// **************************** Sacamos toda la lógica pura, refeactorizando los métodos de la clase **************************** ///


// MARK: - CachingPolicy
extension CachingController {
    
    struct CachingPolicy {
        
        static let expirationTime: TimeInterval = 60 * 10
        static let maximumCacheSize: Bytes = 1024 * 1024 * 10
        
        static func isCacheSizeOverLimit(cacheSize: Bytes) -> Bool {
            return cacheSize > maximumCacheSize
        }
        
        static func cachedValue<V>(from storedValue: StoredValue<V>, withCurrentDate date: Date) -> CachedValue<V> {
            let isStale = date.timeIntervalSince(storedValue.date) > expirationTime
            return CachedValue(value: storedValue.value, isStale: isStale)
        }
        
        static func entriesToRemove(from entries: [StoredEntry]) -> [StoredEntry] {
            let sortedEntries = entries.sorted(by: { $0.date < $1.date })
            var entriesToRemove: [StoredEntry] = []
            var remainingSize = sortedEntries.reduce(Bytes(0)) { $0 + $1.size }
            for entry in sortedEntries {
                guard remainingSize > maximumCacheSize else {
                    break
                }
                entriesToRemove.append(entry)
                remainingSize -= entry.size
            }
            return entriesToRemove
        }
    }
}




