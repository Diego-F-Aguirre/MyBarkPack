//
//  Dog.swift
//  MyBarkPack
//
//  Created by Diego Aguirre on 4/23/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit
import CoreData


class Dog: NSManagedObject {
    static let kClassName = "Dog"

    convenience init?(name: String, age: Int, sex: Bool, image: NSData?, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        guard let entity = NSEntityDescription.entityForName(Dog.kClassName, inManagedObjectContext: context) else { return nil }
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        self.name = name
        self.age = age
        self.sex = sex
        self.image = image
    }
}
