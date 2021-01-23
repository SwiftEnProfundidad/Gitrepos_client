//
//  ModelTypes.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 23/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import Foundation

struct ID {
    let value: Int
}

extension ID: Decodable {
    init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(Int.self)
        self.init(value: value)
    }
}

// Para si se obtienen o no valores de
// las "urls" que traen algunas de las
// propiedades del modelo.
enum RemoteValue<T> {
    case unfetched
    // En el caso de capturar un valor
    // lo alamcenamos en la prop value
    // Como el valor genérico puede ser
    // de any tipo, usamos un genérico.
    case fetched(value: T)
}

// Creamos la estructura genérica
// que contegna una URL y un valor
struct FetchableValue<T> {
    let url: URL
    var value: RemoteValue<T>
    
    // Ponemos la "enum" dentro de la estructura
    // para hacer su relación más clara con ésta
    /// `indirect`Para problemas de recursividad
    indirect enum RemoteValue<T> {
        case unfetched
        case fetched(value: T)
    }
}

extension FetchableValue: Decodable {
    init(from decoder: Decoder) throws {
        let template = try decoder.singleValueContainer().decode((String.self))
        guard let url = URL(template: template) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: ""))
        }
        self.url = url
        value = .unfetched
    }
}






















