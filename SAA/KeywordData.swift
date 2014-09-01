//
//  KeywordData.swift
//  SAA
//
//  Created by Thomas Nowak on 24.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class KeywordData: BasicNetwork {
    
    override init(filter:Filter)
    {
        super.init(filter:filter)
        getData()
    }
    
    
    override func getData()
    {
        
       
        super.getData("TA_TOKEN,COUNT",addfilter:"txtlen ge 3 and txtlen le 20",top:"5",orderby: "COUNT desc",service: "KEYWORDS")
    }
    
    override func refresh()
    {
        Debug.print("KeywordData::refresh")
        super.refresh()
        data=[]
        if(rawdata? != nil)
        {
            
            var l=rawdata!.count
            Debug.print("Have \(l) datasets")
            for var i=0; i<l; i++
            {
                Debug.print("Item \(i)")
                var item=rawdata![i] as? NSDictionary
                Debug.print("KeywordData::refresh::item \(item)")
                if(item? != nil)
                {
                    var name=item!["TA_TOKEN"] as String;
                    var c=item!["COUNT"] as? NSString
                    dump(c)
                    
                    if( c? != nil)
                    {
                        var count:Int64 = c!.longLongValue//NSNumber(c).longLongValue
                        Debug.print("Name :"+name+" count \(count)")
                        var x=ChannelModel(name: name, messages: count)
                        
                        data!.append("\(name) (\(count))")
                        
                    }
                }
            }
            Debug.print("ChannelData::refresh::data = \(data)")
        }
        
    }
}
