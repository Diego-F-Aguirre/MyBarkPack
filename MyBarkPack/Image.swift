//
//  Image.swift
//  MyBarkPack
//
//  Created by Diego Aguirre on 4/23/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit
import pop

class Image: UIImageView {
    private let kSmallScaleAnimation = "smallScaleAnimation"
    private let kSpringAnimation = "springAnimation"
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.size.width / 2.0
        self.clipsToBounds = true
        
        smallScale()
    }
}

extension Image {
    func smallScale() {
        let scaleAnimation = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation.toValue = NSValue(CGSize: CGSizeMake(0.5, 0.5))
        scaleAnimation.completionBlock = {(animation, finished) in
            self.scaleSpringAnimation()
        }
        self.layer.pop_addAnimation(scaleAnimation, forKey: kSmallScaleAnimation)
    }
    
    func scaleSpringAnimation() {
        let springAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        springAnimation.springBounciness = 18
        springAnimation.velocity = NSValue(CGSize: CGSizeMake(2.0, 2.0))
        springAnimation.toValue = NSValue(CGSize: CGSizeMake(1.0, 1.0))
        self.layer.pop_addAnimation(springAnimation, forKey: kSpringAnimation)
    }
}
