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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension DogTableViewCell {
    func updateDogCell(dog: Dog) {
        self.dog = dog
        
//        guard let dogImage = dog.image else { return }
//        profileImage.image = UIImage(data: dogImage)
        
        nameLabel.text = dog.name
        ageLabel.text = String(dog.age)
        pawSexImage.image = UIImage(named: "Paw")
    }
}

