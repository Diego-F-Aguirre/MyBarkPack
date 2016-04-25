//
//  Image.swift
//  MyBarkPack
//
//  Created by Diego Aguirre on 4/23/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class Image: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        self.layer.cornerRadius = CGRectGetWidth(self.layer.frame)/2.0
        self.clipsToBounds = true
    }
}
