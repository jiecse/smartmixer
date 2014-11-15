//
//  Actions.swift
//  smartmixer
//
//  Created by 姚俊光 on 14/9/18.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import Foundation
import CoreData

@objc(Actions)

class Actions: NSManagedObject {

    @NSManaged var desc: String
    @NSManaged var id: NSNumber
    @NSManaged var name: String
    @NSManaged var photo: String
    @NSManaged var timer: NSNumber

}
