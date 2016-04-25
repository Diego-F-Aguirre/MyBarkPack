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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    @IBAction func addDogButtonPressed(sender: AnyObject) {
        let alertController = UIAlertController(title: "Add your dog!", message: "Enter your dog's information below", preferredStyle: .Alert)
        
        var inputNameTextField: UITextField?
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { (_) in
            if let inputNameTextField = inputNameTextField,
                name = inputNameTextField.text
            {
                DogController.sharedController.createDog(name, age: 1, sex: true, image: nil)
                self.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            inputNameTextField = textField
        }
       
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
}

















