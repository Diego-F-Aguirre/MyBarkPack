//
//  SectionHeaderTableViewCell.swift
//  MyBarkPack
//
//  Created by Diego Aguirre on 5/3/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

protocol SectionHeaderTableViewCellDelegate {
    func didSelectUserHeaderTableViewCell(sectionHeader: SectionHeaderTableViewCell, selected: Bool, type: Type)
}

class SectionHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var labelContainerView: LabelContainerView!
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    
    var type: Type?
    
    var delegate: SectionHeaderTableViewCellDelegate?
    var dog: Dog?
    
    let sections = [Type.Meals, Type.Exercise, Type.Health, Type.Training, Type.Misc]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension SectionHeaderTableViewCell {
    @IBAction func plusButtonPressed(sender: AnyObject) {
        if let type = type {
            delegate?.didSelectUserHeaderTableViewCell(self, selected: plusButton.selected, type: type )
        }
    }
    
    func updateDogWithGender(dog: Dog?) {
        guard let dog = dog else { return }
        
        if dog.sex == true {
            labelContainerView.backgroundColor = UIColor.lightBlue()
        } else {
            labelContainerView.backgroundColor = UIColor.lightPink()
        }
    }
}

