//
//  GroupModelController.swift
//  PairRandom
//
//  Created by Thao Doan on 6/22/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation
import CoreData

class GroupModelController {
    static let shared = GroupModelController()
    init() {
        
    }
    func update(group: Group, title: String, name : String) {
        group.title = title
        group.name = name
        savePersitanceStore()
    }
    func savePersitanceStore() {
        do {
            try CoreDataStack.context.save()
        } catch let error {
            print ("Error saving data: \(error), \(error.localizedDescription)")
        }
    }
    func add(name:String, title: String = String()) {
        Group(name: name, title: title)
        savePersitanceStore()
    }
    func delete(group: Group) {
        CoreDataStack.context.delete(group)
        savePersitanceStore()
    }
    
}
