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
    
    var dog: Dog?
    var task: Task?
    var loaded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let dog = self.dog else { return }
        updateViewWithDog(dog)
        
    }
}

extension DogDetailViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let dog = self.dog {
            switch section {
            case 0:
                return dog.tasks.filter({$0.type == String(Type.Meals)}).count
            case 1:
                return dog.tasks.filter({$0.type == String(Type.Exercise)}).count
            case 2:
                return dog.tasks.filter({$0.type == String(Type.Health)}).count
            case 3:
                return dog.tasks.filter({$0.type == String(Type.Training)}).count
            case 4:
                return dog.tasks.filter({$0.type == String(Type.Misc)}).count
            default:
                return 0
            }
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        if let dog = self.dog {
            switch indexPath.section {
            case 0:
                let task = dog.tasks.filter({$0.type == String(Type.Meals)})[indexPath.row] as? Task
                cell.updateTaskCell(task, dog: dog)
                return cell
            case 1:
                let task = dog.tasks.filter({$0.type == String(Type.Exercise)})[indexPath.row] as? Task
                cell.updateTaskCell(task, dog: dog)
                return cell
            case 2:
                let task = dog.tasks.filter({$0.type == String(Type.Health)})[indexPath.row] as? Task
                cell.updateTaskCell(task, dog: dog)
                return cell
            case 3:
                let task = dog.tasks.filter({$0.type == String(Type.Training)})[indexPath.row] as? Task
                cell.updateTaskCell(task, dog: dog)
                return cell
            case 4:
                let task = dog.tasks.filter({$0.type == String(Type.Misc)})[indexPath.row] as? Task
                cell.updateTaskCell(task, dog: dog)
                return cell
            default:
                return cell
            }
        }
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let header = SectionHeaderView()
        return header.sections.count
    }
}

extension DogDetailViewController: UITableViewDelegate, SectionHeaderViewDelegate {
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            if let dog = dog {
                switch indexPath.section {
                case 0:
                    guard let task = dog.tasks.filter({$0.type == String(Type.Meals)})[indexPath.row] as? Task else { return }
                    
                    TaskController.sharedController.deleteTask(task)
                    self.tableView.beginUpdates()
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    self.tableView.endUpdates()
                case 1:
                    guard let task = dog.tasks.filter({$0.type == String(Type.Exercise)})[indexPath.row] as? Task else { return }
                    
                    TaskController.sharedController.deleteTask(task)
                    self.tableView.beginUpdates()
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    self.tableView.endUpdates()
                case 2:
                    guard let task = dog.tasks.filter({$0.type == String(Type.Health)})[indexPath.row] as? Task else { return }
                    
                    TaskController.sharedController.deleteTask(task)
                    self.tableView.beginUpdates()
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    self.tableView.endUpdates()
                case 3:
                    guard let task = dog.tasks.filter({$0.type == String(Type.Training)})[indexPath.row] as? Task else { return }
                    
                    TaskController.sharedController.deleteTask(task)
                    self.tableView.beginUpdates()
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    self.tableView.endUpdates()
                case 4:
                    guard let task = dog.tasks.filter({$0.type == String(Type.Misc)})[indexPath.row] as? Task else { return }
                    
                    TaskController.sharedController.deleteTask(task)
                    self.tableView.beginUpdates()
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    self.tableView.endUpdates()
                default:
                    break
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = NSBundle.mainBundle().loadNibNamed("SectionHeader", owner: self, options: nil).first as? SectionHeaderView
        
        header?.delegate = self
        header?.updateDogWithGender(dog)
        if !loaded {
            header?.runAnimation()
            loaded = true
        } else {
            header?.toggleHiddenItems()
        }
        
        header?.type = header?.sections[section]
        
        header?.sectionTitleLabel.text = header?.sections[section].rawValue
        
        return header
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func didSelectUserHeaderView(sectionHeader: SectionHeaderView, selected: Bool, type: Type) {
        guard let dog = dog else { return }
            let alertController = UIAlertController(title: "Enter a task", message: "How can you please \(dog.name)?", preferredStyle: .Alert)
        
        
        var inputTaskTextField: UITextField?
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            guard let inputTaskTextField = inputTaskTextField,
                text = inputTaskTextField.text else { return }
            
            if let type = sectionHeader.type {
                
                guard let dog = self.dog else { return }
                
                switch type {
                case .Meals:
                    TaskController.sharedController.createTask(text, dog: dog, type: .Meals, isComplete: false)
                case .Exercise:
                    TaskController.sharedController.createTask(text, dog: dog, type: .Exercise, isComplete: false)
                case .Health:
                    TaskController.sharedController.createTask(text, dog: dog, type: .Health, isComplete: false)
                case .Training:
                    TaskController.sharedController.createTask(text, dog: dog, type: .Training, isComplete: false)
                case .Misc:
                    TaskController.sharedController.createTask(text, dog: dog, type: .Misc, isComplete: false)
                }
            }
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alertController.addTextFieldWithConfigurationHandler { textField in
            textField.placeholder = "Enter a task"
            textField.textAlignment =  NSTextAlignment.Center
            inputTaskTextField = textField
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
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
        
        let actionSheet = UIAlertController(title: "Pick or take a Photo!", message: nil, preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .Default) { (_) in
            imagePicker.sourceType = .PhotoLibrary
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        let cameraAction = UIAlertAction(title: "Camera", style: .Default) { (_) in
            imagePicker.sourceType = .Camera
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
        actionSheet.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            actionSheet.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            actionSheet.addAction(photoLibraryAction)
        }
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        guard let info: NSDictionary = info as NSDictionary,
            image: UIImage = info.objectForKey(UIImagePickerControllerOriginalImage) as? UIImage,
            imageData: NSData = UIImagePNGRepresentation(image) else {
                print("No image retrieved")
                return
        }
        
        guard let dog = self.dog else { return }
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
        if let dog = self.dog {
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
}

extension DogDetailViewController: TaskTableViewCellDelegate {
    func checkValueChanged(cell: TaskTableViewCell, selection: Bool) {
        guard let task = cell.task else { return }
        
        TaskController.sharedController.updateCheckValueChanged(task, selected: selection)
        tableView.reloadData()
    }
}
































