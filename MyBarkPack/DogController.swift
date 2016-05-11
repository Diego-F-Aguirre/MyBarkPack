//
//  DogController.swift
//  MyBarkPack
//
//  Created by Diego Aguirre on 4/24/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation
import CoreData

class DogController {
    static let sharedController = DogController()
    private let kDog = "Dog"
    
    var dogs: [Dog] = []
    
    init() {
        dogs = fetchAllDogs() ?? []
    }
}

extension DogController {
    func createDog(name: String, age: Int, sex: Bool, image: NSData?) {
        guard let _ = Dog(name: name, age: age, sex: sex, image: image) else {return}
        saveDog()
        dogs = fetchAllDogs() ?? []
    }
    
    func fetchAllDogs() -> [Dog]? {
        let request = NSFetchRequest(entityName: kDog)
        let context = Stack.sharedStack.managedObjectContext
        
        var dogs: [Dog] = []
        
        do {
            dogs = try context.executeFetchRequest(request) as! [Dog]
        } catch let error as NSError {
            print("failed \(error.localizedDescription) in \(#function)")
            return nil
        }
        return dogs
    }
    
    func updateDog(dog: Dog, newImageData: NSData?) {
        guard let imageData = newImageData else { return }
        dog.image = imageData
        saveDog()
    }
    
    func saveDog() {
        let context = Stack.sharedStack.managedObjectContext
        
        do {
            let _ = try context.save()
        } catch let error as NSError {
            print("error \(error.localizedDescription) in \(#function)")
        }
    }
    
    func removeDog(dog: Dog) {
        dog.managedObjectContext?.deleteObject(dog)
        saveDog()
        dogs = fetchAllDogs() ?? []
    }
}