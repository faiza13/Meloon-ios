//
//  CommentTableViewCell.swift
//  Meloon
//
//  Created by ESPRIT on 14/04/2018.
//  Copyright © 2018 Esprit. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    
    @IBOutlet weak var textComment: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageUser.layer.cornerRadius = imageUser.frame.size.width / 2
        imageUser.clipsToBounds = true    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
