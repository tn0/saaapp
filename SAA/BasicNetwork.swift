//
//  BasicNetwork.swift
//  SAA
//
//  Created by Thomas Nowak on 23.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import Foundation
import UIKit
class BasicNetwork
{
    var delegate:NewDataDelegate?
    var settings:Settings
    var filter:Filter
    var data:Array<AnyObject>?
    var rawdata:NSArray?
    var connections:Int=0
    
    
    
    private struct Constants {
        
        static let batchSize = 128
        
    }
    
    
    init(filter:Filter)
    {
        settings=Settings()
        self.filter=filter
        
        
        
    }
    
    func getData()
    {
        
    }
    
    func makeURL(select:String,addfilter:String,top:String,orderby:String,service:String) -> String
    {
        var url=settings.getUrl()!+"/comline/saa/services/app.xsodata/"+service+"?$format=json"
        
        //select
        var s:String="&$select="+select.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
        
        
        //filter zeitraum
        var w="";
        if(filter.zeitraum.useFilter)
        {
            
            w="(timestamp ge datetime'"+filter.zeitraum.dbbegin+"' and timestamp le datetime'"+filter.zeitraum.dbend+"')"
        }
        
        //filter channels
        var c=""
        for channel in filter.channels.channels
        {
            
            if ( channel.use)
            {
                if(c=="")
                {
                    c="( sn_id eq '"+channel.desc!+"'"
                }
                else
                {
                    c=c+" or sn_id eq '"+channel.desc!+"'"
                }
                
            }
        }
        if(c != "")
        {
            c=c + ")"
            if( w == "")
            {
                w=c
            }
            else
            {
                w=w+" and "+c
            }
        }
        
        //filter keywords
        
        var k=""
        
        for keyword in filter.keywords.keywords
        {
                
            if ( keyword.use)
            {
                if(k=="")
                {
                    k = "("+keyword.desc! + " gt 0 "
                }
                else
                {
                    k = k + " or " + keyword.desc! + " gt 0 "
                }
            }
        }
        
        if(k != "")
        {
            k=k + ")"
        
        
            if( w == "")
            {
                w=k
            }
            else
            {
                w=w+" and "+k
            }
        }
        
        //filter sentiment
        
        var se=""
        
        if ( filter.sentiment.positive)
        {
            if(se=="")
            {
                se = "(TA_TYPE eq 'WeakPositiveSentiment' or TA_TYPE eq 'StrongPositiveSentiment'"
            }
            else
            {
                se = se + " or TA_TYPE eq 'WeakPositiveSentiment' or TA_TYPE eq 'StrongPositiveSentiment'"
            }
        }
        
        if ( filter.sentiment.negative)
        {
            if(se=="")
            {
                se = "(TA_TYPE eq 'WeakNegativeSentiment' or TA_TYPE eq 'StrongNegativeSentiment'"
            }
            else
            {
                se = se + " or TA_TYPE eq 'WeakNegativeSentiment' or TA_TYPE eq 'StrongNegativeSentiment'"
            }
        }
        
        if ( filter.sentiment.neutral)
        {
            if(se=="")
            {
                se = "(TA_TYPE eq 'NeutralSentiment'"
            }
            else
            {
                se = se + " or TA_TYPE eq 'NeutralSentiment' "
            }
        }
        if(se != "")
        {
            se=se + ")"
            
            
            if( w == "")
            {
                w=se
            }
            else
            {
                w=w+" and "+se
            }
        }
        
        
        //additional filters
        if(addfilter != "")
        {
            if(w=="")
            {
                w="("+addfilter+")"
            }
            else
            {
                w=w+" and ( "+addfilter+" )"
            }
        }
        
        //build filter
        if(w != "")
        {
            w="&$filter="+w.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
        }
        
        
        //build $top
        Debug.print("top: "+top)
        var t=""
        if(top != "")
        {
            t="&$top="+top.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
        }
        Debug.print("t: "+t)
        //build orderby
        var o=""
        if(orderby != "")
        {
            o="&$orderby="+orderby.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
        }
        
        url=url+s+w+t+o
        Debug.print("BasicNetwork::getData::url="+url)
        return url
    }
    
    var jsonDictionary:NSDictionary?
    
    func taskComplete(data:NSData?,response:NSURLResponse?,error:NSError?)
    {
       // objc_sync_enter(connections)
        connections--
        if(connections == 0)
        {
            UIApplication.sharedApplication().networkActivityIndicatorVisible=false
        }
       // objc_sync_exit(connections)
        
        
        if(response? != nil)
        {
            Debug.print("taskComplete::request "+response!.debugDescription)
        }
        if(error? != nil)
        {
            Debug.print("taskComplete::error "+error!.debugDescription)
            if(delegate? == nil)
            {
                fatalError("Fehler ")
            }
            else
            {
                delegate?.errorByLoading(self, msg: "\(error!.localizedDescription)")
            }
            return
        }

            if( data? == nil)
        {
            println("Error connecting: \(error)")
            if(delegate? == nil)
            {
                fatalError("Couldn't create connection to server.")
            }
            else
            {
                delegate?.errorByLoading(self, msg: "Keine Verbindung zum Server")
            }
            return
        }
        else
            {
                Debug.print("taskComplete::data "+data!.debugDescription)
        }
        
        
        
        var anyError: NSError?
        jsonDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &anyError) as NSDictionary?
        
        if( jsonDictionary? == nil )
        {
            println("Error creating JSON dictionary: \(anyError)")
            if(delegate? == nil)
            {
                fatalError("Couldn't create JSON dicitonary")
            }
            else
            {
                delegate?.errorByLoading(self, msg: "Kann die Daten nicht interpretieren!")
            }
            return
        }
        else
        {
        Debug.print("taskComplete::json "+jsonDictionary!.debugDescription)
        }
            // Bounce back to the main queue to reload the table view and reenable the fetch button.
        
        NSOperationQueue.mainQueue().addOperationWithBlock {
            
            self.updateData()
            
        }
    }
    
    func refresh()
    {
        var d = jsonDictionary!["d"] as NSDictionary?
        
        if(d? != nil)
        {
            
        Debug.print("BasicNetwork::refresh Type of d")
            dump(d)
            rawdata = d!["results"] as NSArray?
            
        }
        
    }
    
    func updateData()
    {
        Debug.print("BasicNetwork::updateData")
        refresh()
        Debug.print("BasicNetwork::updateData  call delegate.dataLoaded")
        delegate?.dataLoaded(self)
    }
    
    func getData(select:String,addfilter:String,top:String,orderby:String,service:String)
    {
        Debug.print("getData select \(select) addfilter \(addfilter) top \(top) orderby \(orderby) service \(service)")
        var url=makeURL(select,addfilter: addfilter,top: top,orderby: orderby,service: service)
        let jsonURL = NSURL.URLWithString(url)
        let sessionConfiguration = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let userPasswordString = settings.getLogin()!+":"+settings.getPassword()!
        let userPasswordData = userPasswordString.dataUsingEncoding(NSUTF8StringEncoding)
        Debug.print("PasswordData : "+userPasswordString)
        let base64EncodedCredential = userPasswordData!.base64EncodedStringWithOptions(nil)
        let authString = "Basic \(base64EncodedCredential)"
        sessionConfiguration.HTTPAdditionalHeaders = ["Authorization" : authString]
        let session = NSURLSession(configuration: sessionConfiguration)
        let task = session.dataTaskWithURL(jsonURL, completionHandler: taskComplete )
        
        
       // objc_sync_enter(connections)
        connections++
        if(connections > 0)
        {
            UIApplication.sharedApplication().networkActivityIndicatorVisible=true
        }
        //objc_sync_exit(connections)
        
        task.resume()
    }
    

}