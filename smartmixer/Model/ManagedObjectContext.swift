//
//  ManagedObjectContext.swift
//  smartmixer
//
//  Created by Koulin Yuan on 8/27/14.
//  Copyright (c) 2014 Smart Group. All rights reserved.
//

import Foundation
import CoreData

var applicationDocumentsDirectory: NSURL! = {
    let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
    return urls[urls.endIndex-1] as NSURL
    }()

var managedObjectModel: NSManagedObjectModel! = {
    let modelURL = NSBundle.mainBundle().URLForResource("smartmixer", withExtension: "momd")
    return NSManagedObjectModel(contentsOfURL: modelURL!)
    }()

var persistentStoreCoordinator: NSPersistentStoreCoordinator! = {
    var error: NSError? = nil
    /**
    var storeUrl = applicationDocumentsDirectory.URLByAppendingPathComponent("smartmixer.sqlite")
    var _persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    if _persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeUrl, options: nil, error: &error) == nil {
    }
    return _persistentStoreCoordinator
    **/
    var storeUrl = applicationDocumentsDirectory.URLByAppendingPathComponent("smartmixer.sqlite")
    if !NSFileManager.defaultManager().fileExistsAtPath(storeUrl.path!) {
        var preloadUrl = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("smartmixer", ofType: "sqlite")!)
        if !NSFileManager.defaultManager().copyItemAtURL(preloadUrl!, toURL: storeUrl, error: &error) {
            abort()
        }
    }
    
    var pStore = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    if pStore.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeUrl, options: nil, error: &error) == nil {
        abort()
    }
    return pStore
    /* */
    }()

let managedObjectContext: NSManagedObjectContext! = {
    var context = NSManagedObjectContext()
    context.persistentStoreCoordinator = persistentStoreCoordinator
    return context
    }()


let UnitDictory:Dictionary<Int, String> = {
    let fetchRequest = NSFetchRequest()
    fetchRequest.entity = NSEntityDescription.entityForName("Unit", inManagedObjectContext: managedObjectContext)
    
    let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
    let sortDescriptors = [sortDescriptor]
    fetchRequest.sortDescriptors = sortDescriptors
    
    var error: NSError? = nil
    
    var items:[Unit] = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) as [Unit]
    
    var units = Dictionary<Int, String>()
    
    for item in items {
        let id = Int(item.id)
        let name = item.name
        units[id] = name
    }
    
    return units
}()
