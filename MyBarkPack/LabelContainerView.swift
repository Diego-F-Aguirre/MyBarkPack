//
//  LabelContainerView.swift
//  MyBarkPack
//
//  Created by Diego Aguirre on 4/30/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit
import pop

class LabelContainerView: UIView {
    private let kSpringAnimation = "springAnimation"
    private let kSmallScaleAnimation = "smallScaleAnimation"
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 16
        smallScale()
        springAnimation()
    }
}

extension LabelContainerView {
    func smallScale() {
        
        let scaleAnimation = POPBasicAnimation(propertyNamed: kPOPLayerScaleX)
        scaleAnimation.fromValue = NSValue(CGSize: CGSizeMake(0.0, 1.0))
        scaleAnimation.completionBlock = {(animation, finished) in
            self.springAnimation()
        }
        self.layer.pop_addAnimation(scaleAnimation, forKey: kSmallScaleAnimation)
    }
    
    func springAnimation() {
        let spring = POPSpringAnimation(propertyNamed: kPOPLayerScaleX)
        spring.beginTime = CACurrentMediaTime() + 0.5
        spring.springBounciness = 15
        spring.toValue = NSValue(CGSize: CGSizeMake(1.0, 1.0))
        self.layer.pop_addAnimation(spring, forKey: kSpringAnimation)
    }
}