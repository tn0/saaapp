//
//  Filter.swift
//  SAA
//
//  Created by Thomas Nowak on 16.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class Filter: FilterChangedDelegate {
    
    var delegate:FilterChangedDelegate?
    var keywords:Keywords;
    var channels:Channels;
    var zeitraum:Zeitraum;
    var sentiment:Sentiment;
    
    init()
    {
        
        keywords=Keywords()
        
        channels=Channels()
        
        zeitraum=Zeitraum()
        
        sentiment=Sentiment()
        sentiment.delegate=self
        keywords.delegate=self
        channels.delegate=self
        zeitraum.delegate=self
    }
    
   
    func filterChanged()
    {
        delegate?.filterChanged()
    }
}
