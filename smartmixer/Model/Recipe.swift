//
//  Recipe.swift
//  smartmixer
//
//  Created by 姚俊光 on 14/9/18.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import Foundation
import CoreData

@objc(Recipe)

class Recipe: NSManagedObject {

    @NSManaged var alcohol: NSNumber
    @NSManaged var cooktimes: NSNumber
    @NSManaged var des: String
    @NSManaged var difficulty: NSNumber
    @NSManaged var drinktime: NSNumber
    @NSManaged var id: NSNumber
    @NSManaged var isFav: NSNumber
    @NSManaged var largePhoto: String
    @NSManaged var lastUpdateTime: NSDate
    @NSManaged var name: String
    @NSManaged var nameEng: String
    @NSManaged var skill: NSNumber
    @NSManaged var taste: NSNumber
    @NSManaged var thubmnailPhoto: String
    @NSManaged var trytimes: NSNumber
    @NSManaged var type: NSNumber
    @NSManaged var ingredientShip: RecipeIngrdient

}
