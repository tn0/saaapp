//
//  ChannelData.swift
//  SAA
//
//  Created by Thomas Nowak on 23.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import Foundation
class ChannelData :BasicNetwork
{
   
    var sumOfMessages:Int64=0
    var maxMessages:Int64=0
    override init(filter:Filter)
    {
        super.init(filter:filter)
        getData()
    }
    
    func statistik()
    {
        var sum:Int64=0
        var max:Int64=0
        Debug.print("data \(data)")
        for o in data!
        {
            Debug.print("o \(o)")
            var item:ChannelModel=o as ChannelModel
            Debug.print("item \(item)")
            sum = sum + item.messages
            Debug.print("sum \(sum)")
            if(item.messages > max )
            {
                max=item.messages
                Debug.print("max \(max)")
            }
        }
        sumOfMessages=sum
        maxMessages=max
    }
    override func getData()
    {
        
        /*
        order by macht nach Measure mach scheinbar Probleme, wenn kein zusätzlicher Filter angegeben wird
        */
        //super.getData("name,COUNT",addfilter: "",top: "10",orderby: "COUNT desc",service: "CHANNELS")
        super.getData("",addfilter: "",top: "10",orderby: "COUNT desc",service: "CHANNELS")
    }
    
    override func refresh()
    {
        Debug.print("ChannelData::refresh")
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
                    Debug.print("ChannelData::refresh::item \(item)")
                if(item? != nil)
                {
                    var name=item!["name"] as String;
                    var c=item!["COUNT"] as? NSNumber
                    dump(c)
                    
                    if( c? != nil)
                    {
                    var count:Int64 = c!.longLongValue//NSNumber(c).longLongValue
                        Debug.print("Name :"+name+" count \(count)")
                    var x=ChannelModel(name: name, messages: count)
                        
                    data!.append(x)
                
                    }
                }
            }
            Debug.print("ChannelData::refresh::data = \(data)")
        }
        statistik()
    }
    
}