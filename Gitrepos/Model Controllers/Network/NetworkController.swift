//
//  NetworkController.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 24/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import Foundation

class NetWorkController {
    let cachingController = CachingController()
    
    func fetchValue<V: Decodable>(for url: URL) -> V? {
        let cacheValue: CachedValue<V>? = cachingController.fetchValue(for: url)
        return cacheValue?.value
    }
}
