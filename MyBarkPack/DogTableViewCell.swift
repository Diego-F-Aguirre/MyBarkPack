//
//  DogTableViewCell.swift
//  MyBarkPack
//
//  Created by Diego Aguirre on 4/24/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class DogTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: Image!
    @IBOutlet weak var nameContainerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageContainerView: UIView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var pawSexImage: UIImageView!
    
    var dog: Dog?
}

extension DogTableViewCell {
    func updateDogCell(dog: Dog) {
        self.dog = dog
        
        if let dogImage = dog.image {
            profileImage.image = UIImage(data: dogImage)
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


