//
//  ButtonLike.swift
//  Meloon
//
//  Created by ESPRIT on 25/04/2018.
//  Copyright © 2018 Esprit. All rights reserved.
//

import Foundation
import UIKit

class ButtonLike: UIButton {
    
    var params: Dictionary<String, Any>
    override init(frame: CGRect) {
        self.params = [:]
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.params = [:]
        super.init(coder: aDecoder)
    }
    
}
