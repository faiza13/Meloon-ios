//
//  MostLikedTableViewCell.swift
//  Meloon
//
//  Created by ESPRIT on 26/04/2018.
//  Copyright © 2018 Esprit. All rights reserved.
//

import UIKit

class MostLikedTableViewCell: UITableViewCell {

    
    
   
    
    
    
   
    
    
    
    
    
    
    
    @IBOutlet weak var nblikeButton: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var profilButton: UIButton!
    @IBOutlet weak var descriptionPublication: UILabel!
    
    @IBOutlet weak var nameCreator: UILabel!
    @IBOutlet weak var imageCreator: UIImageView!
    
    @IBOutlet weak var imagePublication: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
