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
    
    var tableViewImage: UIImageView?
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.lightBlue()
        tableView.reloadData()
    }
    
    enum Gender: String {
        case Male
        case Female
    }
    
    var dogGender: Gender?
    var loaded: Bool = false
}

extension DogListViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DogController.sharedController.dogs.count != 0 {
            tableView.backgroundView = nil
            tableView.separatorStyle = .SingleLine
            
            return DogController.sharedController.dogs.count
            
        } else {
            let image = UIImage(named: "Empty_TableView")
            let imageView =  UIImageView(image: image)
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            tableView.backgroundView = UIImageView(image: image)
            tableView.separatorStyle = .None

            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("dogCell", forIndexPath: indexPath) as? DogTableViewCell else { return UITableViewCell()}
        
        let dog = DogController.sharedController.dogs[indexPath.row]
        cell.updateDogCell(dog)
        
        if !loaded {
            cell.runAnimation()
            loaded = true
        } else {
            cell.toggleHiddenItems()
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.view.frame.height / 2 - 31
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
        
        let maleAction =  UIAlertAction(title: "Male", style: .Default) { (action) in
            self.dogGender = .Male
            if let inputNameTextField = inputNameTextField,
                text = inputNameTextField.text where text != "",
                let inputAgeTextField = inputAgeTextField,
                age = Int(inputAgeTextField.text!) where age != 0
            {
                confirmationHandler(text, age)
            } else {
                print("No name or age entered")
            }
        }
        
        let femaleAction = UIAlertAction(title: "Female", style: .Default) { (action) in
            self.dogGender = .Female
            if let inputNameTextField = inputNameTextField,
                text = inputNameTextField.text where text != "",
                let inputAgeTextField = inputAgeTextField,
                age = Int(inputAgeTextField.text!) where age != 0
            {
                confirmationHandler(text, age)
            } else {
                print("No name or age entered")
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
        
        alertController.addAction(maleAction)
        alertController.addAction(femaleAction)
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
    @IBAction func addDogButtonPressed(sender: AnyObject) {
        let alert = textBoxAlert(title: "Add your dog!", message: "Enter your dog's information below") { name, age in
            if self.dogGender == .Male {
                let image = UIImage(named: "Male_Silhouette")
                DogController.sharedController.createDog(name, age: Int(age), sex: true, image: UIImagePNGRepresentation(image!))
            } else {
                let image = UIImage(named: "Female_Silhouette")
                DogController.sharedController.createDog(name, age: Int(age), sex: false, image: UIImagePNGRepresentation(image!))
            }
            self.tableView.reloadData()
        }
        presentViewController(alert, animated: true, completion: nil)
    }
}

extension DogListViewController {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDogDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow,
            dogDetailVC = segue.destinationViewController as? DogDetailViewController else { return }
            
           let dog = DogController.sharedController.dogs[indexPath.row]
            dogDetailVC.dog = dog
        }
    }
}
