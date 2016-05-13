//
//  AlertController.swift
//  MyBarkPack
//
//  Created by Diego Aguirre on 5/12/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation
import UIKit
import SimpleAlert

class AlertController: SimpleAlert.Controller {
    override func addTextFieldWithConfigurationHandler(configurationHandler: ((UITextField!) -> Void)?) {
        super.addTextFieldWithConfigurationHandler({ textField in
            
            textField.defaultTextAttributes = ([NSFontAttributeName: UIFont(name: "AvenirNext-Medium", size: 14)!, NSForegroundColorAttributeName: UIColor.blackColor()])
            textField.frame.size.height = 100
            textField.layer.borderColor = nil
            textField.layer.borderWidth = 0
            textField.placeholder = "Enter a task"
            textField.textAlignment =  NSTextAlignment.Center
            textField.autocorrectionType = UITextAutocorrectionType.Default
            configurationHandler?(textField)
        })
    }
    
    override func configurButton(style: SimpleAlert.Action.Style, forButton button: UIButton) {
        super.configurButton(style, forButton: button)
        
        switch style {
        case .OK:
            button.titleLabel?.font = UIFont.boldSystemFontOfSize(20)
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        case .Cancel:
            button.titleLabel?.font = UIFont.boldSystemFontOfSize(20)
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        default:
            break
        }
    }
}
