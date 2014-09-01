//
//  SentimentData.swift
//  SAA
//
//  Created by Thomas Nowak on 23.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import Foundation
class SentimentData :BasicNetwork
{
    
    var positive:Int64=0
    var negative:Int64=0
    var neutral:Int64=0
    override init(filter:Filter)
    {
        super.init(filter:filter)
        getData()
    }
    
    
    override func getData()
    {
        
        positive=Int64(arc4random())
        negative=Int64(arc4random())
        neutral=Int64(arc4random())
        super.getData("TA_TYPE,COUNT",addfilter: "TA_TYPE eq 'StrongPositiveSentiment' or TA_TYPE eq 'WeakPositiveSentiment' or TA_TYPE eq 'NeutralSentiment' or TA_TYPE eq 'WeakNegativeSentiment' or TA_TYPE eq 'StrongNegativeSentiment'",top: "",orderby: "",service: "SENTIMENT")
    }
    
    override func refresh()
    {
        Debug.print("SentimentData::refresh")
        super.refresh()
        positive=0
        negative=0
        neutral=0
        if(rawdata? != nil)
        {
            
            var l=rawdata!.count
            Debug.print("Have \(l) datasets")
            for var i=0; i<l; i++
            {
                Debug.print("Item \(i)")
                var item=rawdata![i] as? NSDictionary
                Debug.print("SentimentData::refresh::item \(item)")
                
                if(item? != nil)
                {
                    
                    var type=item!["TA_TYPE"] as String;
                    var c=item!["COUNT"] as? NSString
                    
                    
                    if( c? != nil)
                    {
                        var count:Int64 = c!.longLongValue//NSNumber(c).longLongValue
                        Debug.print("type :"+type+" count \(count)")
                        if(type == "WeakNegativeSentiment" || type == "StrongNegativeSentiment")
                        {
                            negative=negative+count
                        }
                        if(type == "WeakPositiveSentiment" || type == "StrongPositiveSentiment")
                        {
                            positive=positive+count
                        }
                        if(type == "NeutralSentiment" )
                        {
                            neutral=neutral+count
                        }
                        
                        
                    }

                }
            }
            Debug.print("ChannelData::refresh::data = \(data)")
        }
        
    }
}
