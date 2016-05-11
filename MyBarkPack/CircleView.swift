//
//  CircleView.swift
//  MyBarkPack
//
//  Created by Diego Aguirre on 4/30/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit
import pop

class CircleView: UIView {
     private let kSmallScaleAnimation = "smallScaleAnimation"
    private let kSpringAnimation = "springAnimation"
    
    override func awakeFromNib() {
        self.layer.cornerRadius = CGRectGetWidth(self.layer.frame)/2.0
        self.clipsToBounds = true
        
        smallScale()
    }
}

extension CircleView {
    func springAnimation() {
        let spring = POPSpringAnimation(propertyNamed: kPOPLayerScaleX)
        spring.beginTime = CACurrentMediaTime() + 0.5
        spring.springBounciness = 15
        spring.toValue = NSValue(CGSize: CGSizeMake(1.0, 1.0))
        self.layer.pop_addAnimation(spring, forKey: kSpringAnimation)
    }
    
    func smallScale() {
        let scaleAnimation = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation.fromValue = NSValue(CGSize: CGSizeMake(0.2, 0.2))
        scaleAnimation.completionBlock = {(animation, finished) in
            self.springAnimation()
        }
        self.layer.pop_addAnimation(scaleAnimation, forKey: kSmallScaleAnimation)
    }
}
