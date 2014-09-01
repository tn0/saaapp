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
        var dateComponents=calendar.components( NSCalendarUnit.YearCalendarUnit | NSCalendarUnit.MonthCalendarUnit | NSCalendarUnit.DayCalendarUnit | NSCalendarUnit.TimeZoneCalendarUnit | NSCalendarUnit.HourCalendarUnit | NSCalendarUnit.MinuteCalendarUnit  | NSCalendarUnit.SecondCalendarUnit | NSCalendarUnit.QuarterCalendarUnit, fromDate: date)
        return dateComponents
    }
    
    static func dayOfWeek(date:NSDate) -> Int
    {
        var calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        var components = calendar.components(NSCalendarUnit.WeekdayCalendarUnit, fromDate: date)
        var day=components.weekday - 2
        return day
    }
    
    static func startOfWeek(date:NSDate) -> NSDate
    {
        
        var calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        var dateComponents=DateUtilities.getComponents(calendar,date:date)
        dateComponents.day=dateComponents.day - dayOfWeek(date) + 2
        var begin=calendar.dateFromComponents(dateComponents)
        return begin!
    }
    
    static func endOfWeek(date:NSDate) -> NSDate
    {
        var calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        
        var dateComponents=DateUtilities.getComponents(calendar,date:date)
        dateComponents.day=dateComponents.day + (7 - dayOfWeek(date) ) + 1
        var end=calendar.dateFromComponents(dateComponents)
        return end!    }
    
    static func startOfMonth(date:NSDate) -> NSDate
    {
        var calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        
        var dateComponents=DateUtilities.getComponents(calendar,date:date)
        dateComponents.day = 1
        var begin=calendar.dateFromComponents(dateComponents)
        return begin!
    }
    
    static func endOfMonth(date:NSDate) -> NSDate
    {
        var calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        var dateComponents=DateUtilities.getComponents(calendar,date:date)
        var range=calendar.rangeOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitMonth, forDate: date)
        dateComponents.day=range.length
        var end=calendar.dateFromComponents(dateComponents)
        return end!
    }
    
    
    static func startOfYear(date:NSDate) -> NSDate
    {
        var calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        var dateComponents=DateUtilities.getComponents(calendar,date:date)
        dateComponents.day = 1
        dateComponents.month=1
        var begin=calendar.dateFromComponents(dateComponents)
        return begin!
    }
    
    static func startOfQuartal(date:NSDate) -> NSDate
    {
        var calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        var dateComponents=DateUtilities.getComponents(calendar,date:date)
        var range=calendar.rangeOfUnit(NSCalendarUnit.CalendarUnitMonth, inUnit: NSCalendarUnit.CalendarUnitQuarter, forDate: date)
        Debug.print("DateUtilities::startOfQuratal range \(range)")
        dateComponents.day = 1
        dateComponents.month=range.location
        dateComponents.hour=12
        
        var begin=calendar.dateFromComponents(dateComponents)
        return begin!
    }
    
    static func endOfQuartal(date:NSDate) -> NSDate
    {
        var calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        var dateComponents=DateUtilities.getComponents(calendar,date:date)
        var range=calendar.rangeOfUnit(NSCalendarUnit.CalendarUnitMonth, inUnit: NSCalendarUnit.CalendarUnitQuarter, forDate: date)
        dateComponents.month=range.location+range.length-1
        var begin=calendar.dateFromComponents(dateComponents)
        var end=DateUtilities.endOfMonth(begin!)
        return end
    }
    
    static func startOfTime(date:NSDate) -> NSDate
    {
        var calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        var dateComponents=DateUtilities.getComponents(calendar,date:date)
        dateComponents.day = 1
        dateComponents.month=1
        dateComponents.year=1970
        var begin=calendar.dateFromComponents(dateComponents)
        return begin!
    }

    static func endOfTime(date:NSDate) -> NSDate
    {
        var calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        var dateComponents=DateUtilities.getComponents(calendar,date:date)
        dateComponents.day = 1
        dateComponents.month=1
        dateComponents.year=2038
        var begin=calendar.dateFromComponents(dateComponents)
        return begin!
    }
    
    static func dayOfMonth(date:NSDate,day:Int) -> NSDate
    {
        Debug.print("DateUtilities::DayOfMonth set \(date) to \(day)")
        var calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        var dateComponents=DateUtilities.getComponents(calendar,date:date)
        dateComponents.day = day
        var begin=calendar.dateFromComponents(dateComponents)
        Debug.print("DateUtilities::DayOfMonth Result \(begin)" )
        return begin!
    }
    
    static func endOfYear(date:NSDate) -> NSDate
    {
        Debug.print("DateUtilities::EndOfYear")
        var calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        var dateComponents=DateUtilities.getComponents(calendar,date:date)
        Debug.print("dateComponents start \(dateComponents)")
        dateComponents.day=31
        dateComponents.month=12
        Debug.print("dateComponents end \(dateComponents)")
        
        var end=calendar.dateFromComponents(dateComponents)
        Debug.print("Date end \(end)")
        return end!
    }
    
    
    
    
    static func oneWeekBack(date:NSDate) -> NSDate
    {
        var calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        var dateComponents=DateUtilities.getComponents(calendar,date:date)
        dateComponents.weekOfYear=dateComponents.weekOfYear - 1
        var week=calendar.dateFromComponents(dateComponents)
        return week!;
    }
    
    static func oneMonthBack(date:NSDate) -> NSDate
    {
        var calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        var dateComponents=DateUtilities.getComponents(calendar,date:date)
        Debug.print("Date \(date) year \(dateComponents.year)  month \(dateComponents.month) day \(dateComponents.day)")
        if(dateComponents.month == 1 )
        {
            dateComponents.year--
            dateComponents.month=12
        }
        else
        {
            dateComponents.month--
        }
        Debug.print("Date \(date) year \(dateComponents.year)  month \(dateComponents.month) day \(dateComponents.day)")
        var month=calendar.dateFromComponents(dateComponents)
        Debug.print("month \(date) year \(dateComponents.year)  month \(dateComponents.month) day \(dateComponents.day)")
        return month!;
    }
    
    static func oneMonthFor(date:NSDate) -> NSDate
    {
        var calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        var dateComponents=DateUtilities.getComponents(calendar,date:date)
        if(dateComponents.month == 12 )
        {
            dateComponents.year++
            dateComponents.month=1
        }
        else
        {
            dateComponents.month++
        }
        var month=calendar.dateFromComponents(dateComponents)
        return month!;
    }
    static func oneYearBack(date:NSDate) -> NSDate
    {
        var calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        var dateComponents=DateUtilities.getComponents(calendar,date:date)
        dateComponents.year=dateComponents.year - 1
        var year=calendar.dateFromComponents(dateComponents)
        return year!;
    }
    
}