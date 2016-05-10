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
    var dog: Dog?
    
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
    func updateTaskCell(task: Task?, dog: Dog?) {
        
        if let dog = dog {
            if let task = task {
                self.task = task
                
                titleLabel.text = task.title
                checkBoxButton.selected = task.isChecked.boolValue
                
                switch dog.sex {
                case true:
                    if task.isChecked.boolValue == false {
                        titleLabel.textColor = UIColor.blackColor()
                        self.checkBoxButton.setImage(UIImage(named: "Empty_Check_Box"), forState: .Normal)
                    } else if task.isChecked.boolValue == true {
                        titleLabel.textColor = UIColor.grayColor()
                        self.checkBoxButton.setImage(UIImage(named: "Checked_Box"), forState: .Normal)
                    }
                case false:
                    if task.isChecked.boolValue == false {
                        titleLabel.textColor = UIColor.blackColor()
                        self.checkBoxButton.setImage(UIImage(named: "Pink_Empty_Check_Box"), forState: .Normal)
                    } else if task.isChecked.boolValue == true {
                        titleLabel.textColor = UIColor.grayColor()
                        self.checkBoxButton.setImage(UIImage(named: "Pink_Checked_Box"), forState: .Normal)
                    }
                default:
                    break
                }
            }
        }
    }
}

protocol TaskTableViewCellDelegate: class {
    func checkValueChanged(cell: TaskTableViewCell, selection: Bool)
}
