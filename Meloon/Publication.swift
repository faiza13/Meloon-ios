
//  Hero.swift
//  CustomTableView
//
//  Created by Belal Khan on 30/07/17.
//  Copyright © 2017 Belal Khan. All rights reserved.
//

class Publication {
    
    var id: String?
    var idCreator: String?
    var description: String?
    var image: String?
    var nameCreator: String?
    var imageCreator: String?
    var nbjaime: String?
    var nbComment: Int?


    
    init(id: String, idCreator: String,description: String , image: String , nameCreator : String , imageCreator : String, nbJaime: Int , nbComment: Int) {
        self.id = id
        self.idCreator = idCreator
        self.description = description
        self.image = image
        self.nameCreator  = nameCreator
        self.imageCreator  = imageCreator
        self.nbComment  = nbComment

       
    }
    init(id : String , description: String , image: String , nameCreator : String ,  imageCreator : String, nbjaime : String) {
        self.id = id
        self.description = description
        self.image       = image
        self.nameCreator = nameCreator
        self.imageCreator = imageCreator
        self.nbjaime = nbjaime
       
    }
    
    init() {
        
       
        
    }
}
