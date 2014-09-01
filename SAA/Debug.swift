//
//  Debug.swift
//  SAA
//
//  Created by Thomas Nowak on 25.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import Foundation
struct Debug
{
    static var debug:Bool=true
    static func print(str:String)
    {
        if(Debug.debug)
         {
            NSOperationQueue.mainQueue().addOperationWithBlock {
                
                println(str)
            }
            
        }
    }
    
}