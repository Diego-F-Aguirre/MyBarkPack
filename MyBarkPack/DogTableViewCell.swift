//
//  DogTableViewCell.swift
//  MyBarkPack
//
//  Created by Diego Aguirre on 4/24/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit
import pop

class DogTableViewCell: UITableViewCell {
    private let kSpringAnimation = "springAnimation"
    private let kSmallScaleAnimation = "smallScaleAnimation"
    
    @IBOutlet weak var profileImage: Image!
    @IBOutlet weak var nameContainerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageContainerView: UIView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var pawSexImage: UIImageView!
    
    var dog: Dog?
    var loaded: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.hidden = true
        ageLabel.hidden = true
    }
    
    func runAnimation() {
        smallScale()
        springAnimation()
    }
    
    func toggleHiddenItems() {
        nameLabel.hidden = false
        ageLabel.hidden = false
    }
}

extension DogTableViewCell {
    func updateDogCell(dog: Dog) {
        self.dog = dog
        
        if let dogImage = dog.image {
            let image = UIImage(data: dogImage)
            
            self.profileImage.image = image
            self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
            
        } else {
            profileImage.image = nil
        }
        
        nameLabel.text = dog.name
        ageLabel.text = String(dog.age)
        
        
        if dog.sex == true {
            nameContainerView.backgroundColor = UIColor.lightBlue()
            
            pawSexImage.image = UIImage(named: "Paw")
            ageContainerView.backgroundColor = UIColor.lightBlue()
            
            
        } else {
            nameContainerView.backgroundColor = UIColor.lightPink()
            pawSexImage.image = UIImage(named: "Female_Paw")
            ageContainerView.backgroundColor = UIColor.lightPink()
        }
    }
}

extension DogTableViewCell {
    func smallScale() {
        
        let scaleAnimation = POPBasicAnimation(propertyNamed: kPOPLayerScaleX)
        scaleAnimation.fromValue = NSValue(CGSize: CGSizeMake(0.0, 1.0))
        scaleAnimation.completionBlock = {(animation, finished) in
            self.springAnimation()
            self.toggleHiddenItems()
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
