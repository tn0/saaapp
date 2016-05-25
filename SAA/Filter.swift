//
//  Filter.swift
//  SAA
//
//  Created by Thomas Nowak on 16.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class Filter: FilterChangedDelegate,NewDataDelegate {
    
    var delegate:FilterChangedDelegate?
    
    var keywords:Keywords;
    var channels:Channels;
    var zeitraum:Zeitraum;
    var sentiment:Sentiment;
    var keywordUpdater:KeywordFilter?
    var channelUpdater:ChannelFilter?
    
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
        update()
        
    }
    func getData()
    {
        keywordUpdater?.getData();
        channelUpdater?.getData();
    }
    
    
    func update()
    {
        if(keywordUpdater == nil)
        {
            keywordUpdater=KeywordFilter(filter: self)
            keywordUpdater!.delegate=self
        }
        if(channelUpdater == nil)
        {
            channelUpdater=ChannelFilter(filter: self)
            channelUpdater!.delegate=self
            
        }
    }
    
    func dataLoaded(sender: BasicNetwork)
    {
        
        let data:[AnyObject]=sender.data!
        let fdata:[BasicFilter]=data as! [BasicFilter]
        if(sender is KeywordFilter)
        {
            keywords.keywords=fdata
        }
        else if( sender is ChannelFilter )
        {
            channels.channels=fdata
        }
    }
    
    func errorByLoading(sender: BasicNetwork, msg: String)
    {
        Debug.print("Error to get data for \(sender)")
    }
   
    func filterChanged()
    {
        delegate?.filterChanged()
    }
}
