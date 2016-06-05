//
//  Todo.swift
//  Crowlie
//
//  Created by Antonia Blair on 5/29/16.
//  Copyright © 2016 Antonia Blair. All rights reserved.
//

import UIKit

class Todo: NSObject, NSCoding {
    // MARK: Properties
    var name: String
    var frequency: String?
    var completed: Bool
    
    // MARK: Archiving Paths - where stuff is saved will go here
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("todos")
    
    // MARK: Types (property keys will go here)
    struct PropertyKey {
        static let nameKey = "name"
        static let frequencyKey = "frequency"
        static let completedKey = "completed"
    }
    
    // MARK: Initializing
    init?(name: String, frequency: String?, completed: Bool) {
        self.name = name
        self.frequency = frequency
        self.completed = completed
        
        super.init()

        if name.isEmpty {
            return nil
        }
    }
    
    // MARK: NSCoding (TBD)
    // encode value of each property on the Meal class and store them with their corresponding key
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(frequency, forKey: PropertyKey.frequencyKey)
        aCoder.encodeBool(completed, forKey: PropertyKey.completedKey)
    }
    // declaring this initializer as a convenience initializer because it only applies when there’s saved data to be loaded.
    required convenience init?(coder aDecoder: NSCoder) {
        
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let frequency = aDecoder.decodeObjectForKey(PropertyKey.frequencyKey) as? String
        let completed = aDecoder.decodeBoolForKey(PropertyKey.completedKey)
        
        // Must call designated initializer.
        self.init(name: name, frequency: frequency, completed: completed)
    }
    
}
