//
//  Date.swift
//  Taskit
//
//  Created by Carlos Calderon on 11/23/14.
//  Copyright (c) 2014 Calderware. All rights reserved.
//

import Foundation

class Date {
    class func from(#year: Int, month: Int, day: Int) -> NSDate {
        
        var components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        var calendar = NSCalendar(identifier: NSGregorianCalendar)
        
        var date = calendar?.dateFromComponents(components)
        return date!
    }
    
    class func toString(#date: NSDate) -> String {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateStringFormatter.stringFromDate(date)
        return dateString
    }
}
