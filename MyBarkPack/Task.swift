//
//  Task.swift
//  MyBarkPack
//
//  Created by Diego Aguirre on 5/5/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation
import CoreData

enum Type: String {
    case Meals
    case Exercise
    case Health
    case Training
    case Misc 
}


class Task: NSManagedObject {
    static let kClassName = "Task"
    
    convenience init?(title: String, type: Type, isComplete: Bool, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        guard let entity = NSEntityDescription.entityForName(Task.kClassName, inManagedObjectContext: context) else { return nil }
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        self.title = title
        self.isChecked = isComplete
        self.type = type.rawValue
    }
}
