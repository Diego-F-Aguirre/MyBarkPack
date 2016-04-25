//
//  TaskTableViewCell.swift
//  MyBarkPack
//
//  Created by Diego Aguirre on 4/24/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension TaskTableViewCell {
    func updateTaskCell(task: Task) {
        
    }
}
