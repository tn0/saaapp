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
    
    var _freetext:String=""
    var freetext:String
        {
        get
        {
            return _freetext
            
        }
        set
        {
            _freetext = newValue
            if(_freetext.isEmpty)
            {
                _freetext_used=false
            }
            else
            {
                _freetext_used=true
            }
            delegate?.filterChanged()
        }
    }
    
    var _freetext_used:Bool=false
    var freetext_used:Bool
        {
        get
        {
            return _freetext_used
            
        }
        set
        {
            if(!freetext.isEmpty)
            {
                _freetext_used = newValue
            }
            delegate?.filterChanged()
        }
    }
    
    var _keywords:[BasicFilter]=[]
    var keywords:[BasicFilter]
        {
        get{
        return _keywords
        }
        set {
            _keywords=newValue
            for i in keywords
            {
                i.delegate=self
            }
            delegate?.filterChanged()
        }
    }
    
    
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