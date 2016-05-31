//
//  TaskController.swift
//  MyBarkPack
//
//  Created by Diego Aguirre on 4/24/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    private let kTask = "Task"
    var fetchedResultsController: NSFetchedResultsController
    
    init(dog: Dog) {
        let request = NSFetchRequest(entityName: kTask)
        let sortDescriptor1 = NSSortDescriptor(key: "type", ascending: true)
        let predicate = NSPredicate(format: "dog == %@", dog)
        request.predicate = predicate
        
        request.sortDescriptors = [sortDescriptor1]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: String(Type), cacheName: nil)
        _ = try? fetchedResultsController.performFetch()
        
    }
}

extension TaskController {
    func createTask(title: String, dog: Dog, type: Type, isComplete: Bool) {
        if let task = Task(title: title, type: type, isComplete: isComplete) {
            
            task.dog = dog
            
            saveTask()
        }
    }
    
    func saveTask() {
        let context = Stack.sharedStack.managedObjectContext
        
        do {
            let _ = try context.save()
        } catch let error as NSError {
            print("failed \(error.localizedDescription) in \(#function)")
        }
    }
    
    func deleteTask(task:Task) {
        task.managedObjectContext?.deleteObject(task)
        saveTask()
    }
    
    func updateCheckValueChanged(task: Task, selected: Bool) {
        task.isChecked = !task.isChecked.boolValue
        saveTask()
    }
}