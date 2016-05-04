//
//  SectionHeaderTableViewCell.swift
//  MyBarkPack
//
//  Created by Diego Aguirre on 5/3/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

protocol SectionHeaderTableViewCellDelegate {
    func didSelectUserHeaderTableViewCell(selected: Bool, sectionHeader: SectionHeaderTableViewCell)
}

class SectionHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var labelContainerView: LabelContainerView!
    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    var delegate: SectionHeaderTableViewCellDelegate?
    var dog: Dog? {
        return DogDetailViewController.dog
    }
    
    let section = ["Meals", "Exercise", "Health", "Training", "Misc"]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        guard let dog = dog else { return }
        if dog.sex == true {
            labelContainerView.backgroundColor = UIColor.lightBlue()
        } else {
            labelContainerView.backgroundColor = UIColor.lightPink()
        }
        
    }
}

extension SectionHeaderTableViewCell {
    @IBAction func plusButtonPressed(sender: AnyObject) {
     delegate?.didSelectUserHeaderTableViewCell(true, sectionHeader: self)
    }
}
