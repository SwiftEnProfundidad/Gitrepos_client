//
//  Decoding.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 23/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import Foundation

extension URL {
    init?(template: String) {
        let regex = "\\{.*\\}"
        let cleanedString = template.replacingOccurrences(of: regex, with: "", options: .regularExpression)
        self.init(string: cleanedString)
    }
}

extension KeyedDecodingContainer {
    func value<T>(forKey key: KeyedDecodingContainer.Key) throws -> T where T: Decodable {
        return try decode(T.self, forKey: key)
    }
}
