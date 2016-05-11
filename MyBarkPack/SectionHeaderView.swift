//
//  SectionHeaderView.swift
//  MyBarkPack
//
//  Created by Diego Aguirre on 5/10/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit
import pop

protocol SectionHeaderViewDelegate: class {
    func didSelectUserHeaderView(sectionHeader: SectionHeaderView, selected: Bool, type: Type)
}

class SectionHeaderView: UITableViewHeaderFooterView {
    private let kSpringAnimation = "springAnimation"
    private let kSmallScaleAnimation = "smallScaleAnimation"
    
    @IBOutlet weak var labelContainerView: LabelContainerView!
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    
    var type: Type?
    
    weak var delegate: SectionHeaderViewDelegate?
    var dog: Dog?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sectionTitleLabel.hidden = true
        plusButton.hidden = true
        smallScale()
        springAnimation()
    }
    
    let sections = [Type.Meals, Type.Exercise, Type.Health, Type.Training, Type.Misc]
    
    func updateDogWithGender(dog: Dog?) {
        guard let dog = dog else { return }
        
        if dog.sex == true {
            labelContainerView.backgroundColor = UIColor.lightBlue()
        } else {
            labelContainerView.backgroundColor = UIColor.lightPink()
        }
    }
    
    @IBAction func plusButtonPressed(sender: AnyObject) {
        if let type = type {
            delegate?.didSelectUserHeaderView(self, selected: plusButton.selected, type: type )
        }
    }
    
}

extension SectionHeaderView {
    func smallScale() {
 
        let scaleAnimation = POPBasicAnimation(propertyNamed: kPOPLayerScaleX)
        scaleAnimation.fromValue = NSValue(CGSize: CGSizeMake(0.0, 1.0))
        scaleAnimation.completionBlock = {(animation, finished) in
                self.springAnimation()
                self.sectionTitleLabel.hidden = false
                self.plusButton.hidden = false
            
        }
        self.layer.pop_addAnimation(scaleAnimation, forKey: kSmallScaleAnimation)
    }
    
    func springAnimation() {
        let spring = POPSpringAnimation(propertyNamed: kPOPLayerScaleX)
        spring.beginTime = CACurrentMediaTime() + 0.5
        spring.springBounciness = 15
        spring.toValue = NSValue(CGSize: CGSizeMake(1.0, 1.0))
//        spring.velocity = NSValue(CGSize: CGSizeMake(2.0, 2.0))
        self.layer.pop_addAnimation(spring, forKey: kSpringAnimation)
    }
}

