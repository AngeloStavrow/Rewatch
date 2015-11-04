//
//  PersistenceController.swift
//  Rewatch
//
//  Created by Romain Pouclet on 2015-11-03.
//  Copyright © 2015 Perfectly-Cooked. All rights reserved.
//

import UIKit
import CoreData

class PersistenceController: NSObject {
    typealias InitCallback = () -> Void
    
    enum PersistenceError: ErrorType {
        case InitializationError
    }
    
    private(set) var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
    private(set) var privateObjectContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
    
    let initCallback: InitCallback
    
    init(initCallback: InitCallback) throws {
        self.initCallback = initCallback
        
        super.init()

        guard let modelURL = NSBundle.mainBundle().URLForResource("DataModel", withExtension: "momd") else {
            throw PersistenceError.InitializationError
        }
        
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
            throw PersistenceError.InitializationError
        }
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: mom)
        privateObjectContext.persistentStoreCoordinator = coordinator

        managedObjectContext.parentContext = privateObjectContext
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () -> Void in
            guard let psc = self.privateObjectContext.persistentStoreCoordinator else { return }
            
            var options = [String: AnyObject]()
            options[NSMigratePersistentStoresAutomaticallyOption] = true
            options[NSInferMappingModelAutomaticallyOption] = true
            options[NSSQLitePragmasOption] = ["journal_mode": "DELETE"]
            
            let fileManager = NSFileManager.defaultManager()
            guard let documentsURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last else { return }
            let storeURL = documentsURL.URLByAppendingPathComponent("DataModel.sqlite")
            
            do {
                try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: options)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.initCallback()
                })
            } catch {
                // TODO how to handle error properly ?
            }
        }
    }
    
    func save() {
        guard !privateObjectContext.hasChanges && !managedObjectContext.hasChanges else { return }
        
        managedObjectContext.performBlockAndWait { () -> Void in
            guard let _ = try? self.managedObjectContext.save() else { return }
            self.privateObjectContext.performBlockAndWait({ () -> Void in
                let _ = try? self.privateObjectContext.save()
            })
        }
    }
}
