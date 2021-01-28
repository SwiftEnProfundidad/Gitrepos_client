//
//  UsersTableViewDataSource.swift
//  Gitrepos
//
//  Created by Juan Carlos Merlos Albarracin on 27/1/21.
//  Copyright © 2021 Swift En Profundidad. All rights reserved.
//

import UIKit

/// Analicemos lo que debe hacer una fuente de datos, en general:
/// `lógica:` organizar los datos para la table view en secciones y filas
/// `comportamiento:` pasar información a la table view (nº de secciones y filas, celdas, etc.)

/// Podemos mirar la estructura `DataOrganizer` y ver la lógica completa por separado de las vistas de tabla,
/// celdas, delegación, etc. Esto hace que sea mucho más fácil razonar sobre la lógica y asegurar
/// que sea correcta. Podemos probar esta estructura de inmediato. No necesitamos implementar el código en
/// UsersTableViewDataSource, extraer celdas o ejecutar la aplicación. Tampoco necesitamos dobles de prueba.


class UsersTableViewDataSource: NSObject {
    internal var dataOrganizer: ArrayDataSourceOrganizer<User>
    internal var viewModelCache: [IndexPath : UserCell.ViewModel] = [ : ]
    
    init(users: [User]) {
        dataOrganizer = ArrayDataSourceOrganizer(items: users)
        super.init()
    }
}

// MARK: - ArrayTableViewDataSource

extension UsersTableViewDataSource: ArrayTableViewDataSource {
    func viewModel(for value: User) -> UserCell.ViewModel {
        return UserCell.ViewModel(user: value)
    }
    
    func configure(cell: UserCell, with viewModel: UserCell.ViewModel) {
        cell.viewModel = viewModel
    }
}

// MARK: UITableViewDataSource

extension UsersTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell(from: tableView, for: indexPath)
    }
    
}

/// `UsersTableViewDataSource.DataOrganizer` organiza los datos para la table view.

// MARK: - DataOrganizer

private extension UsersTableViewDataSource {
    struct DataOrganizer {
        
        /// mantener la variedad de usuarios
        let users: [User]
        
        /// devolver el recuento de filas
        var rowCounts: Int {
            return users.count
        }
        
        /// devolver el usuario correcto para cada fila
        subscript(indexPath: IndexPath) -> User {
            return users[indexPath.row]
        }
    }
}

/// Aquí es donde conectamos los datos del modelo con con los datos de la vista.
/// `UserCell.ViewModel`, define los datos que la celda necesita y los formatea.
/// La extensión `UserCell.ViewModel` traduce un user en un `UserCell.ViewModel`
extension UserCell.ViewModel {
    init(user: User) {
        username = user.login
        avatar = #imageLiteral(resourceName: "Avatar")
        guard case let .fetched(details) = user.details.value else {
            return
        }
        name = details.name ?? ""
        bio = details.bio ?? ""
        location = details.location ?? ""
    }
}
