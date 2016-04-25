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
    static let sharedController = TaskController()
    private let kTask = "Task"
    
    var dog: Dog?
    
    var tasks: [Task] {
        guard let dog = dog,
            tasks = fetchAllTasksForDog(dog) else { return [] }
        return tasks
    }
}

extension TaskController {
    func createTask(title: String, isComplete: Bool) {
        let _ = Task(title: title, isComplete: isComplete)
        saveTask()
    }
    
    func fetchAllTasksForDog(dog: Dog) -> [Task]? {
        let request = NSFetchRequest(entityName: kTask)
        
        var tasks: [Task] = []
        
        do {
           tasks = try dog.managedObjectContext?.executeFetchRequest(request) as! [Task]
        } catch let error as NSError {
            print("failed \(error.localizedDescription) in \(#function)")
            return nil
        }
        return tasks
    }
    
//    func updateTask(task: Task, newTitle: String, isComplete: Bool) {
//        task.title = newTitle
//        task.isChecked = isComplete.boolValue
//    }
    
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
}