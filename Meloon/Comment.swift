//
//  Comment.swift
//  coachApp
//
//  Created by ESPRIT on 29/03/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import Foundation
class Comment {
    var id: String?
    var contents: String?
    var idUser: String?
    var username: String?
    var email: String?
    var imageUser: String?
 
    
    init(id: String, contents: String ,  idUser: String ,   username: String ,    email: String ,      imageUser: String
) {
        self.id = id
        self.idUser = idUser
        self.username = username
        self.email = email
        self.imageUser  = imageUser
        self.contents = contents
    }
}
