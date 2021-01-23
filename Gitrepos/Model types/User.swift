//
//  User.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 22/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit
import Foundation

struct User {
    let login: String
    let id: Int
    let avatar: UIImage
    var details: Details?
    var repositories: [Repository]?
    var stars: [Repository]?
    var followers: [User]?
    var following: [User]?
    var followed: Bool?
}

// MARK: - Details
extension User {
    struct Details {
        let publicRepositoriesCount: Int
        let followersCount: Int
        let followingCount: Int
        let name: String?
        let company: String?
        let blog: URL?
        let location: String?
        let email: String?
        let bio: String?
    }
}
/** Los opcionales y let/var deben considerarse por separado.
 
 Un opcional es para algo que podría no estar allí.
 
 Let se usa para campos que no deberían cambiar, var para propiedades que podrían cambiar en el futuro (en este caso, porque deben descargarse por separado).
 
 Puede combinar estos dos y tener variaciones:
 
 ***`let no opcional`: campos que siempre tienen un valor y no cambian. El inicio de sesión de un usuario es un ejemplo.
 
 ***`let opcional`: campos que pueden no tener un valor y no cambian. Un ejemplo es la empresa de un usuario. Si hacemos una llamada y no está allí, es nula. Pero no puede cambiar en nuestra aplicación. Eso requiere enviar datos a la API primero (lo cubro en el módulo 4)
 
 ***`var no opcional`: campos que pueden cambiar pero no pueden estar vacíos. No hay tal ejemplo aquí. Una cantidad de dinero en una cuenta bancaria es un ejemplo. Puede que no haya dinero (0), pero siempre debe haber un número. Cubro estados vacíos en las próximas lecciones.
 
 ****`var opcional`: campos que pueden cambiar y también pueden estar vacíos. En nuestro caso los repositores de un usuario son un ejemplo. Al principio no tenemos información, porque vienen a través de una llamada separada a la API, por lo que la propiedad debe ser nula. Después de hacer la segunda llamada, tenemos que cambiarla a una matriz.*/
