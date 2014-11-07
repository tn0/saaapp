//
//  Chanals.swift
//  SAA
//
//  Created by Thomas Nowak on 21.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class Channels:FilterChangedDelegate {
    var delegate:FilterChangedDelegate?
    
    var _channels:[BasicFilter]=[]
    var channels:[BasicFilter]
        {
        get{
            return _channels
        }
        set {
            _channels=newValue
            for i in _channels
            {
                i.delegate=self
            }
            delegate?.filterChanged()
        }
    }
    
   
    init()
    {
        for i in channels
        {
            i.delegate=self
        }
    }
    func filterChanged()
    {
        delegate?.filterChanged()
    }
}
