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
    
    static var dog: Dog?
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let dog = DogDetailViewController.dog else { return }
        updateViewWithDog(dog)
    }
}

extension DogDetailViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  TaskController.sharedController.tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        
        let task = TaskController.sharedController.tasks[indexPath.row]
        cell.updateTaskCell(task)
        cell.delegate = self
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let header = SectionHeaderTableViewCell()
        return header.section.count
    }
}

extension DogDetailViewController: UITableViewDelegate, SectionHeaderTableViewCellDelegate {
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let task = TaskController.sharedController.tasks[indexPath.row]
            TaskController.sharedController.deleteTask(task)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableCellWithIdentifier("sectionHeader") as? SectionHeaderTableViewCell else { return UITableViewCell() }
        
        header.delegate = self
        header.sectionTitleLabel.text = header.section[section]
        
        
        return header
    }
    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 25.0
//    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func didSelectUserHeaderTableViewCell(selected: Bool, sectionHeader: SectionHeaderTableViewCell) {
        TaskController.sharedController.createTask("new item", isComplete: false)
        print("Cell selected")
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
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        guard let info: NSDictionary = info as NSDictionary,
            image: UIImage = info.objectForKey(UIImagePickerControllerOriginalImage) as? UIImage,
            imageData: NSData = UIImagePNGRepresentation(image) else {
                print("No image retrieved")
                return
        }
        
        guard let dog = DogDetailViewController.dog else { return }
        DogController.sharedController.updateDog(dog, newImageData: imageData)
        self.dogProfileImage.image = UIImage(data: dog.image!)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func maleColorUpdates() {
        navigationController?.navigationBar.barTintColor = UIColor.lightBlue()
    }
    
    func femaleColorUpdates() {
        navigationController?.navigationBar.barTintColor = UIColor.lightPink()
    }
}

extension DogDetailViewController {
    func updateViewWithDog(dog: Dog) {
        if let dog = DogDetailViewController.dog {
            self.title = dog.name
        }
        
        if let image = dog.image {
            dogProfileImage.image = UIImage(data: image)
        }
        
        if dog.sex == true {
            maleColorUpdates()
        } else {
            femaleColorUpdates()
        }
    }
    
    func updateViewWithTask(task: Task) {
//        if let task = self.task {
//            if let
//        }
    }
}

extension DogDetailViewController: TaskTableViewCellDelegate {
    func checkValueChanged(cell: TaskTableViewCell, selection: Bool) {
        guard let task = cell.task else { return }
        
        TaskController.sharedController.updateCheckValueChanged(task, selected: selection)
        tableView.reloadData()
    }
}
































