//
//  NewDataDelegate.swift
//  SAA
//
//  Created by Thomas Nowak on 23.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import Foundation
protocol NewDataDelegate {
    func dataLoaded(sender: BasicNetwork)
    
    func errorByLoading(sender: BasicNetwork, msg: String)
    
}