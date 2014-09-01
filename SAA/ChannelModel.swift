//
//  ChannelModel.swift
//  SAA
//
//  Created by Thomas Nowak on 23.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import Foundation
class ChannelModel
{
    var name:String
    var messages:Int64
    init( name: String , messages:Int64)
    {
        self.name=name
        self.messages=messages
    }
}