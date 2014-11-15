//
//  RecipeIngrdient.swift
//  smartmixer
//
//  Created by 姚俊光 on 14/9/18.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import Foundation
import CoreData

@objc(RecipeIngrdient)

class RecipeIngrdient: NSManagedObject {

    @NSManaged var id: NSNumber
    @NSManaged var ingridientId: NSNumber
    @NSManaged var recipeId: NSNumber
    @NSManaged var ingrdientship: NSSet
    @NSManaged var recipeship: NSSet

}
