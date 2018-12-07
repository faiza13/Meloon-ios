//
//  ViewControllerTableViewCell.swift
//  Meloon
//
//  Created by ESPRIT on 10/04/2018.
//  Copyright © 2018 Esprit. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionPublication: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var nameCreator: UILabel!
    
    @IBOutlet weak var imageCreator: UIImageView!
    @IBOutlet weak var imagePublication: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
    @IBOutlet weak var nblikeButton: UILabel!
    @IBOutlet weak var profilButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageCreator.layer.cornerRadius = 8.0
        imageCreator.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
