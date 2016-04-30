//
//  CircleView.swift
//  MyBarkPack
//
//  Created by Diego Aguirre on 4/30/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class CircleView: UIView {
    override func awakeFromNib() {
        self.layer.cornerRadius = CGRectGetWidth(self.layer.frame)/2.0
        self.clipsToBounds = true
    }
}
