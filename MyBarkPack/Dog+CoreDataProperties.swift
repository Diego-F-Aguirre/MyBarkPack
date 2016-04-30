//
//  Dog+CoreDataProperties.swift
//  MyBarkPack
//
//  Created by Diego Aguirre on 4/23/16.
//  Copyright © 2016 home. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Dog {
    @NSManaged var name: String
    @NSManaged var age: NSNumber
    @NSManaged var sex: NSNumber
    @NSManaged var image: NSData?
    @NSManaged var tasks: NSSet

}
