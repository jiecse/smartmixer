//
//  Ingridient.swift
//  smartmixer
//
//  Created by 姚俊光 on 14/9/18.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import Foundation
import CoreData

@objc(Ingridient)

class Ingridient: NSManagedObject {

    @NSManaged var buyLink: String
    @NSManaged var categoryId: NSNumber
    @NSManaged var density: NSNumber
    @NSManaged var desc: String
    @NSManaged var id: NSNumber
    @NSManaged var iHave: NSNumber
    @NSManaged var alcohol: NSNumber
    @NSManaged var largePhoto: String
    @NSManaged var lastUpdateTime: NSDate
    @NSManaged var name: String
    @NSManaged var nameEng: String
    @NSManaged var showcolor: NSNumber
    @NSManaged var thubmnailPhoto: String
    @NSManaged var unitId: NSNumber
    @NSManaged var randiship: RecipeIngrdient

}
