//
//  Unit.swift
//  smartmixer
//
//  Created by 姚俊光 on 14/9/18.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import Foundation
import CoreData

@objc(Unit)

class Unit: NSManagedObject {

    @NSManaged var abbreviation: String
    @NSManaged var id: NSNumber
    @NSManaged var measurable: NSNumber
    @NSManaged var name: String

}
