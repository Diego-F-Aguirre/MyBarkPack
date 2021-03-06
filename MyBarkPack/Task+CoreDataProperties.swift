//
//  Task+CoreDataProperties.swift
//  MyBarkPack
//
//  Created by Diego Aguirre on 5/5/16.
//  Copyright © 2016 home. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Task {

    @NSManaged var isChecked: NSNumber
    @NSManaged var title: String
    @NSManaged var type: String
    @NSManaged var dog: Dog?

}
