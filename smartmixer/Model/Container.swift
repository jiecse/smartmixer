//
//  Container.swift
//  smartmixer
//
//  Created by 姚俊光 on 14/9/18.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import Foundation
import CoreData

@objc(Container)

class Container: NSManagedObject {

    @NSManaged var des: String
    @NSManaged var id: NSNumber
    @NSManaged var largePhoto: String
    @NSManaged var lastUpdateTime: NSDate
    @NSManaged var name: String
    @NSManaged var nameEng: String
    @NSManaged var possess: NSNumber
    @NSManaged var thubmnailPhoto: String
    @NSManaged var unitId: NSNumber
    @NSManaged var volume: NSNumber

}
