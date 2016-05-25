//
//  KeywordData.swift
//  SAA
//
//  Created by Thomas Nowak on 24.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit
import Foundation

class KeywordData: BasicNetwork {
    
    override init(filter:Filter)
    {
        super.init(filter:filter)
        getData()
    }
    
    
    override func getData()
    {
        
       
        super.getData("",addfilter:"",top:"5",orderby: "COUNT desc",service: "KEYWORDS")
    }
    
    override func refresh()
    {
        Debug.print("KeywordData::refresh")
        super.refresh()
        data=[]
        if(rawdata != nil)
        {
            
            let l=rawdata!.count
            Debug.print("Have \(l) datasets")
            if(l > 0)
            {
            for i in 0...l-1
            {
                Debug.print("Item \(i)")
                let item=rawdata![i] as? NSDictionary
                Debug.print("KeywordData::refresh::item \(item)")
                if(item != nil)
                {
                    let name=item!["TA_TOKEN"] as! String;
                    let c=item!["COUNT"] as? NSNumber
                    dump(c)
                    
                    if( c != nil)
                    {
                        
                        let count:Int64 = c!.longLongValue
                        Debug.print("Name :"+name+" count \(count)")
                        //var x=ChannelModel(name: name, messages: count)
                        
                        data!.append("\(name) (\(count))")
                        
                    }
                }
            }
            }
            Debug.print("ChannelData::refresh::data = \(data)")
        }
        
    }
}
