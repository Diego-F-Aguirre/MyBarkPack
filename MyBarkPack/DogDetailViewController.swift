//
//  DogDetailViewController.swift
//  MyBarkPack
//
//  Created by Diego Aguirre on 4/24/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class DogDetailViewController: UIViewController {
    @IBOutlet weak var dogProfileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension DogDetailViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  TaskController.sharedController.tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        
        let task = TaskController.sharedController.tasks[indexPath.row]
        
        
        return cell
    }
}

extension DogDetailViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let task = TaskController.sharedController.tasks[indexPath.row]
            TaskController.sharedController.deleteTask(task)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}

extension DogDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBAction func backButtonPressed(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func cameraButtonPressed(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
//        let alertController = UIAlertController(title: "Doggie portrait!", message: "Choose a profile photo for your dog", preferredStyle: .Alert)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        guard let info: NSDictionary = info as NSDictionary else { return }
        
        let image: UIImage = info.objectForKey(UIImagePickerControllerOriginalImage) as! UIImage
        
        dogProfileImage.image = image
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}






























