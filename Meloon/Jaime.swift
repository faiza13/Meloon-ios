//
//  Jaime.swift
//  coachApp
//
//  Created by ESPRIT on 29/03/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import Foundation
class Jaime {
    var id: Int?
    var user: User?
    var publication: Publication?
    init(id: Int , user:User, publication: Publication) {
        self.id = id
        self.user = user
        self.publication = publication
    }

}
