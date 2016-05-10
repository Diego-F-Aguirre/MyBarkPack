//
//  SectionHeaderView.swift
//  MyBarkPack
//
//  Created by Diego Aguirre on 5/10/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView {

    
    @IBOutlet weak var labelContainerView: LabelContainerView!
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    
    var type: Type?
    
    weak var delegate: SectionHeaderViewDelegate?
    var dog: Dog?
    
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

protocol SectionHeaderViewDelegate: class {
    func didSelectUserHeaderView(sectionHeader: SectionHeaderView, selected: Bool, type: Type)
}