//
//  ChannelFilter.swift
//  SAA
//
//  Created by Thomas Nowak on 17.9.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import Foundation
class ChannelFilter: BasicNetwork {
    
    override init(filter:Filter)
    {
        super.init(filter:filter)
        getData()
    }
    
    
    override func getData()
    {
        
        //ToDo: Customer abfragen?
        //var addfilter:String="" //"CUSTOMER eq '"+settings.getCustomer()!+"'"
        let addfilter:String="";
        super.getData("",addfilter:addfilter,top:"",orderby: "",service: "FILTER_CHANNELS")
    }
    
    override func refresh()
    {
        Debug.print("ChannelFilter::refresh")
        super.refresh()
        data=[]
        if(rawdata != nil)
        {
            
            let l=rawdata!.count
            Debug.print("Have \(l) datasets")
            if( l > 0 )
            {
            for i in 0...l-1
            {
                Debug.print("Item \(i)")
                let item=rawdata![i] as? NSDictionary
                Debug.print("KeywordData::refresh::item \(item)")
                if(item != nil)
                {
                    let name=item!["name"] as! String;
                    let sn_id=item!["sn_id"] as! String;
                    data!.append(BasicFilter(name: name,desc: sn_id))
                }
            }
            }
            Debug.print("ChannelData::refresh::data = \(data)")
        }
        
    }
}