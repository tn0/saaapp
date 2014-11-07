//
//  sentiment.swift
//  SAA
//
//  Created by Thomas Nowak on 16.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class Sentiment: NSObject {
    var delegate:FilterChangedDelegate?
    var _positive:Bool;
    var _neutral:Bool;
    var _negative:Bool;
    
    var positive:Bool {
    get {
        return _positive
    }
    set {
        _positive=newValue
        delegate?.filterChanged()
    }
    }
    var neutral:Bool
    {
    get {
    return _neutral
    }
    set {
    _neutral=newValue
    delegate?.filterChanged()
    }
    }
    var negative:Bool
    {
    get {
    return _negative
    }
    set {
    _negative=newValue
    delegate?.filterChanged()
    }
    }
    override init() {
        _positive=true
        _neutral=true
        _negative=true
    }
}
