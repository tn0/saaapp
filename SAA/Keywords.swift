//
//  Keywords.swift
//  SAA
//
//  Created by Thomas Nowak on 21.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import Foundation
class Keywords:FilterChangedDelegate
{
    var delegate:FilterChangedDelegate?
    var _filter:Bool
    var filter:Bool {
      get
      {
         return _filter
      }
      set
      {
         _filter=newValue
        delegate?.filterChanged()
      }
    }
    
    var keywords=[
        BasicFilter(name: "Consors",desc: "consors"),
        BasicFilter(name: "Tranding",desc: "trading"),
        BasicFilter(name: "Depot",desc: "depot"),
        BasicFilter(name: "Broker",desc: "broker"),
        BasicFilter(name: "Stock",desc: "stock"),
        
    ]
    init()
    {
        _filter=true
        
        for i in keywords
        {
            i.delegate=self
        }
    }
    
    func filterChanged()
    {
        delegate?.filterChanged()
    }
}