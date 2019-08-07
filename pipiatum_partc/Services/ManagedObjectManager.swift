//
//  ManagedObjectManager.swift
//  pipiatum_core
//
//  Created by KC Leung on 19/11/2017.
//  Copyright © 2017 Trumptech. All rights reserved.
//

import UIKit
import CoreData

class ManagedObjectManager {
    
    private var moc: NSManagedObjectContext
    
    init(_ moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func insertNewObject(forEntityName: String) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: forEntityName, into: moc)
    }
    
    func deleteObject(object: NSManagedObject) {
        self.moc.delete(object)
    }
    
    func newFetchRequest(forEntityName: String) -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest<NSFetchRequestResult>(entityName: forEntityName)
    }
    
    func fetch(request: NSFetchRequest<NSFetchRequestResult>) throws -> [Any] {
        return try self.moc.fetch(request)
    }
    
    func save() {
        do {
            try moc.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
}
