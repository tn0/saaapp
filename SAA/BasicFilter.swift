//
//  BasicFilter.swift
//  SAA
//
//  Created by Thomas Nowak on 21.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import Foundation

class BasicFilter
{
    var delegate:FilterChangedDelegate?
    var _name:String
    var desc:String?
    var name:String{
    get{
        return _name
    }
    set {
        _name=newValue
        delegate?.filterChanged()
    }
    }
    
    var _use:Bool
    var use:Bool
    {
    get{
        return _use
    }
    set {
        _use=newValue
        delegate?.filterChanged()
    }
    }
    init(name:String,desc:String?)
    {
        self.desc=desc
        _name=name
        _use=false
    }
    
}