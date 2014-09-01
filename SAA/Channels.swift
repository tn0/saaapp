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
    var channels=[
        BasicFilter(name: "Twitter",desc: "TW"),
        BasicFilter(name:"CC Community",desc: "CC"),
    ]
   
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
