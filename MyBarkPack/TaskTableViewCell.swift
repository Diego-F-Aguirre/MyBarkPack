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
    
    var task: Task?
    var delegate: TaskTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension TaskTableViewCell {
    @IBAction func checkBoxButtonPressed(sender: AnyObject) {
        delegate?.checkValueChanged(self, selection: checkBoxButton.selected)
    }
    
}

extension TaskTableViewCell {
    func updateTaskCell(task: Task) {
        self.task = task
        
        titleLabel.text = task.title
        checkBoxButton.selected = task.isChecked.boolValue
        
        if task.isChecked.boolValue {
            self.checkBoxButton.imageView?.image = UIImage(named: "Empty_Check_Box")
        } else {
            self.checkBoxButton.imageView?.image = UIImage(named: "Checked_Box")
        }
    }
}

protocol TaskTableViewCellDelegate: class {
    func checkValueChanged(cell: TaskTableViewCell, selection: Bool)
}
