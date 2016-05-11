//
//  TaskButton.swift
//  MyBarkPack
//
//  Created by Diego Aguirre on 5/9/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit
import pop

class TaskButton: UIButton {
    private let kSmallScaleAnimation = "smallScaleAnimation"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addTarget(self, action: #selector(springAnimation), forControlEvents: .TouchUpInside)
        self.addTarget(self, action: #selector(springAnimation), forControlEvents: .TouchDragExit)
    }
}

extension TaskButton {
    func springAnimation() {
        let spring = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        spring.springBounciness = 20
        spring.toValue = NSValue(CGSize: CGSizeMake(1.0, 1.0))
        spring.velocity = NSValue(CGSize: CGSizeMake(3.0, 3.0))
        self.layer.pop_addAnimation(spring, forKey: "springAnimation")
    }
}

