//
//  DogListViewController.swift
//  MyBarkPack
//
//  Created by Diego Aguirre on 4/23/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class DogListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
}

extension DogListViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DogController.sharedController.dogs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("dogCell", forIndexPath: indexPath) as? DogTableViewCell else { return UITableViewCell()}
        
        let dog = DogController.sharedController.dogs[indexPath.row]
        cell.updateDogCell(dog)
        
        return cell
    }
}

extension DogListViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let dog = DogController.sharedController.dogs[indexPath.row]
            DogController.sharedController.removeDog(dog)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}

extension DogListViewController {
    func textBoxAlert(title title: String, message: String, confirmationHandler: (String, Int) -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        var inputNameTextField: UITextField?
        var inputAgeTextField: UITextField?
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { _ in
            
            if let inputNameTextField = inputNameTextField,
                text = inputNameTextField.text where text != "",
                let inputAgeTextField = inputAgeTextField,
                age = Int(inputAgeTextField.text!) where age != 0
            {
                //                alertController.actions[0].enabled = true
                confirmationHandler(text, age)
            } else {
                print("No name or age entered")
                //                alertController.actions[0].enabled = false
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alertController.addTextFieldWithConfigurationHandler { textField in
            textField.placeholder = "Enter a name"
            textField.textAlignment =  NSTextAlignment.Center
            inputNameTextField = textField
        }
        
        alertController.addTextFieldWithConfigurationHandler { textField in
            textField.placeholder = "Enter an age"
            textField.textAlignment =  NSTextAlignment.Center
            textField.keyboardType = UIKeyboardType.NumberPad
            inputAgeTextField = textField
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
    @IBAction func addDogButtonPressed(sender: AnyObject) {
        let alert = textBoxAlert(title: "Add your dog!", message: "Enter your dog's information below") { name, age in
            DogController.sharedController.createDog(name, age: Int(age), sex: true, image: nil)
            self.tableView.reloadData()
        }
        presentViewController(alert, animated: true, completion: nil)
    }
}

extension DogListViewController {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDogDetail" {
            guard let destinationVC = segue.destinationViewController as? DogDetailViewController,
                indexPath = tableView.indexPathForSelectedRow else { return }
            
            let dog = DogController.sharedController.dogs[indexPath.row]
            destinationVC.dog = dog
        }
    }
}
