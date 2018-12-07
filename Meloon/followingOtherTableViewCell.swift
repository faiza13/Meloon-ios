//
//  followingOtherTableViewCell.swift
//  Meloon
//
//  Created by ESPRIT on 20/04/2018.
//  Copyright © 2018 Esprit. All rights reserved.
//

import UIKit

class followingOtherTableViewCell: UITableViewCell {
    @IBOutlet weak var imageUser: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
