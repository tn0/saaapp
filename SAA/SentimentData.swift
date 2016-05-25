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
        super.getData("",addfilter: "",top: "",orderby: "",service: "SENTIMENT")
    }
    
    override func refresh()
    {
        Debug.print("SentimentData::refresh")
        super.refresh()
        positive=0
        negative=0
        neutral=0
        if(rawdata != nil)
        {
            
            let l=rawdata!.count
            Debug.print("Have \(l) datasets")
            if l > 0
            {
            for  i in 0..<l
            {
                Debug.print("Item \(i)")
                let item:NSDictionary?=rawdata![i] as? NSDictionary
                Debug.print("SentimentData::refresh::item \(item)")
                
                if(item != nil)
                {
                    
                    let type:String=item!["TA_TYPE"] as! String;
                    let c:NSNumber?=item!["COUNT"] as? NSNumber
                    
                    
                    if( c != nil)
                    {
                        let count:Int64 = c!.longLongValue//NSNumber(c).longLongValue
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
            }
            Debug.print("SentimentData::refresh::positive = \(positive) negative \(negative) neutral \(neutral)")
        }
        
    }
}
