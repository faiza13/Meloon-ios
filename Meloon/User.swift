//
//  User.swift
//  coachApp
//
//  Created by ESPRIT on 29/03/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import Foundation
class User {
    var id: String?
    var username: String?
    var email: String?
    var phone: String?
    var imageUser: String?
    var nbfollow: Int?
    var nbfollowed: Int?
  
    var listVideo = [User]()
    init() {
         }
    init(id: String ,firstName: String , username: String , email: String , phone: String , imageUser: String , nbfollow: Int , nbfollowed: Int) {

        self.id = id
        self.username = username
        self.email = email
       self.phone = phone
        self.imageUser = imageUser
        self.nbfollow = nbfollow
        self.nbfollowed = nbfollowed

    }
    
    init(id: String , username: String , email: String , imageUser: String  ) {
        
        self.id = id
        self.email = email
        self.username = username
        self.imageUser = imageUser
        
    }
    
}
