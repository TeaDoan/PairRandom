//
//  CoreDataStack.swift
//  PairRandom
//
//  Created by Thao Doan on 6/22/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation
import CoreData
struct CoreDataStack {
    static let container: NSPersistentContainer = {
        let appName = Bundle.main.object(forInfoDictionaryKey: (kCFBundleNameKey as String)) as! String
        let container = NSPersistentContainer(name:"Group")
        container.loadPersistentStores() { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    static var context: NSManagedObjectContext { return container.viewContext }
}
