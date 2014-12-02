//
//  ActivityModel.swift
//  Taskit
//
//  Created by Carlos Calderon on 11/30/14.
//  Copyright (c) 2014 Calderware. All rights reserved.
//

import Foundation
import CoreData
@objc(ActivityModel)
class ActivityModel: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var activity: String
    @NSManaged var subActivity: String
    @NSManaged var isComplete: NSNumber

}
