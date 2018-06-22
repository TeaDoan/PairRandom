//
//  Group+Convenience.swift
//  PairRandom
//
//  Created by Thao Doan on 6/22/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation
import CoreData

extension Group {
   @discardableResult convenience init(name : String, title: String, insertInto context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.title = title
        self.name = name
    }
}
