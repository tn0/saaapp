//
//  KeywordFilter.swift
//  SAA
//
//  Created by Thomas Nowak on 5.9.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import Foundation
class KeywordFilter: BasicNetwork {
    
    override init(filter:Filter)
    {
        super.init(filter:filter)
        getData()
    }
    
    
    override func getData()
    {
        
    
        var addfilter:String="CUSTOMER eq '"+settings.getCustomer()!+"'"
        super.getData("",addfilter:addfilter,top:"",orderby: "",service: "FILTER_KEYWORDS")
    }
    
    override func refresh()
    {
        Debug.print("KeywordFilter::refresh")
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
                    var name=item!["KEYWORD"] as String;
                    data!.append(BasicFilter(name: name,desc: name))
                }
            }
            Debug.print("ChannelData::refresh::data = \(data)")
        }
        
    }
}