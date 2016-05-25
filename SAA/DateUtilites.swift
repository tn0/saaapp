//
//  File.swift
//  SAA
//
//  Created by Thomas Nowak on 22.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import Foundation

struct DateUtilities
{
    
    static func getComponents(calendar:NSCalendar,date:NSDate) -> NSDateComponents
    {
        
        let dateComponents:NSDateComponents=calendar.components( [ .Year , .Month , .Day , .TimeZone , .Hour , .Minute , .Second , .Quarter ], fromDate: date)
        return dateComponents
    }
    
    static func dayOfWeek(date:NSDate) -> Int
    {
        let calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let components:NSDateComponents = calendar.components(.Weekday, fromDate: date)
        let  day:Int=components.weekday
        return day
    }
    
    static func startOfWeek(date:NSDate) -> NSDate
    {
        
        let calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let dateComponents=DateUtilities.getComponents(calendar,date:date)
        dateComponents.day=dateComponents.day - dayOfWeek(date)
        let begin=calendar.dateFromComponents(dateComponents)
        return begin!
    }
    
    static func endOfWeek(date:NSDate) -> NSDate
    {
        let calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        let dateComponents=DateUtilities.getComponents(calendar,date:date)
        dateComponents.day=dateComponents.day + (7 - dayOfWeek(date) )
        let end=calendar.dateFromComponents(dateComponents)
        return end!    }
    
    static func startOfMonth(date:NSDate) -> NSDate
    {
        let calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        let dateComponents=DateUtilities.getComponents(calendar,date:date)
        dateComponents.day = 1
        let begin=calendar.dateFromComponents(dateComponents)
        return begin!
    }
    
    static func endOfMonth(date:NSDate) -> NSDate
    {
        let calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let dateComponents:NSDateComponents=DateUtilities.getComponents(calendar,date:date)
        let range:NSRange=calendar.rangeOfUnit(.Day, inUnit: .Month, forDate: date)
        dateComponents.day=range.length
        let end:NSDate=calendar.dateFromComponents(dateComponents)!
        return end
    }
    
    
    static func startOfYear(date:NSDate) -> NSDate
    {
        let calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let dateComponents=DateUtilities.getComponents(calendar,date:date)
        dateComponents.day = 1
        dateComponents.month=1
        let begin=calendar.dateFromComponents(dateComponents)
        return begin!
    }
    
    static func startOfQuartal(date:NSDate) -> NSDate
    {
        let calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let dateComponents:NSDateComponents=DateUtilities.getComponents(calendar,date:date)
        let range:NSRange=calendar.rangeOfUnit(.Month, inUnit:  .Quarter, forDate: date)
        Debug.print("DateUtilities::startOfQuratal range \(range)")
        dateComponents.day = 1
        dateComponents.month=range.location
        dateComponents.hour=12
        
        let begin:NSDate=calendar.dateFromComponents(dateComponents)!
        return begin
    }
    
    static func endOfQuartal(date:NSDate) -> NSDate
    {
        let calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let dateComponents:NSDateComponents=DateUtilities.getComponents(calendar,date:date)
        let range:NSRange=calendar.rangeOfUnit(.Month, inUnit: .Quarter, forDate: date)
        dateComponents.month=range.location+range.length-1
        let begin:NSDate=calendar.dateFromComponents(dateComponents)!
        let end:NSDate=DateUtilities.endOfMonth(begin)
        return end
    }
    
    static func startOfTime(date:NSDate) -> NSDate
    {
        let calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let dateComponents=DateUtilities.getComponents(calendar,date:date)
        dateComponents.day = 1
        dateComponents.month=1
        dateComponents.year=1970
        let begin=calendar.dateFromComponents(dateComponents)
        return begin!
    }

    static func endOfTime(date:NSDate) -> NSDate
    {
        let calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let dateComponents=DateUtilities.getComponents(calendar,date:date)
        dateComponents.day = 1
        dateComponents.month=1
        dateComponents.year=2038
        let begin=calendar.dateFromComponents(dateComponents)
        return begin!
    }
    
    static func dayOfMonth(date:NSDate,day:Int) -> NSDate
    {
        Debug.print("DateUtilities::DayOfMonth set \(date) to \(day)")
        let calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let dateComponents=DateUtilities.getComponents(calendar,date:date)
        dateComponents.day = day
        let begin=calendar.dateFromComponents(dateComponents)
        Debug.print("DateUtilities::DayOfMonth Result \(begin)" )
        return begin!
    }
    
    static func endOfYear(date:NSDate) -> NSDate
    {
        Debug.print("DateUtilities::EndOfYear")
        let calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let dateComponents=DateUtilities.getComponents(calendar,date:date)
        Debug.print("dateComponents start \(dateComponents)")
        dateComponents.day=31
        dateComponents.month=12
        Debug.print("dateComponents end \(dateComponents)")
        
        let end=calendar.dateFromComponents(dateComponents)
        Debug.print("Date end \(end)")
        return end!
    }
    
    
    
    
    static func oneWeekBack(date:NSDate) -> NSDate
    {
        let calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let dateComponents=DateUtilities.getComponents(calendar,date:date)
        dateComponents.weekOfYear=dateComponents.weekOfYear - 1
        let week=calendar.dateFromComponents(dateComponents)
        return week!;
    }
    
    static func oneMonthBack(date:NSDate) -> NSDate
    {
        let calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let dateComponents=DateUtilities.getComponents(calendar,date:date)
        Debug.print("Date \(date) year \(dateComponents.year)  month \(dateComponents.month) day \(dateComponents.day)")
        if(dateComponents.month == 1 )
        {
            dateComponents.year -= 1
            dateComponents.month=12
        }
        else
        {
            dateComponents.month -= 1
        }
        Debug.print("Date \(date) year \(dateComponents.year)  month \(dateComponents.month) day \(dateComponents.day)")
        let month=calendar.dateFromComponents(dateComponents)
        Debug.print("month \(date) year \(dateComponents.year)  month \(dateComponents.month) day \(dateComponents.day)")
        return month!;
    }
    
    static func oneMonthFor(date:NSDate) -> NSDate
    {
        let calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let dateComponents=DateUtilities.getComponents(calendar,date:date)
        if(dateComponents.month == 12 )
        {
            dateComponents.year += 1
            dateComponents.month=1
        }
        else
        {
            dateComponents.month += 1
        }
        let month=calendar.dateFromComponents(dateComponents)
        return month!;
    }
    static func oneYearBack(date:NSDate) -> NSDate
    {
        let calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let dateComponents=DateUtilities.getComponents(calendar,date:date)
        dateComponents.year=dateComponents.year - 1
        let year=calendar.dateFromComponents(dateComponents)
        return year!;
    }
    
}