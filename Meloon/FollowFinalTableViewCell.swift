//
//  FollowFinalTableViewCell.swift
//  Meloon
//
//  Created by ESPRIT on 13/05/2018.
//  Copyright © 2018 Esprit. All rights reserved.
//

import UIKit

class FollowFinalTableViewCell: UITableViewCell {

    
   
    
    @IBOutlet weak var unfollow: UIButton!
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var email: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageUser.layer.cornerRadius = 8.0
        imageUser.clipsToBounds = true}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
