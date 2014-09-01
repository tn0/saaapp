//
//  Zeitraum.swift
//  SAA
//
//  Created by Thomas Nowak on 21.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import Foundation
class Zeitraum
{
    var formatter:NSDateFormatter
    var delegate:FilterChangedDelegate?
    var _begin:NSDate
    var begin:NSDate
    {
    get{
        return _begin
    }
    set {
        _begin=newValue
        delegate?.filterChanged()
    }
    }
    var _end:NSDate
    var end:NSDate
    {
    get{
        return _end
    }
    set {
        _end=newValue
        delegate?.filterChanged()
    }
    }
    var _useFilter:Bool
    var useFilter:Bool
    {
    get{
        return _useFilter
    }
    set {
        _useFilter=newValue
        delegate?.filterChanged()
    }
    }

    var dbbegin:String
    {
    get {
        return formatter.stringFromDate(_begin)+"00:00:00.0"
    }
    }
    
    var dbend:String
    {
    get {
        return formatter.stringFromDate(_end)+"23:59:59.9"
    }
    }
    
    init()
    {
        
        _begin=NSDate()
        _end=NSDate()
        formatter=NSDateFormatter()
        formatter.dateFormat="yyyy-MM-dd "
        _useFilter=false
        
    }


    
    
}



