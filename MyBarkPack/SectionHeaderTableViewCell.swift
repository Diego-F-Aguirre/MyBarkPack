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
    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    var delegate: SectionHeaderTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension SectionHeaderTableViewCell {
    @IBAction func plusButtonPressed(sender: AnyObject) {
     delegate?.didSelectUserHeaderTableViewCell(true, sectionHeader: self)
    }
}
