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
    var data:[AnyObject]?
    var rawdata:NSArray?
    var connections:Int=0
    
    
    
    private struct Constants
    {
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
        Debug.print("Making URL for service \(service)")
        var url=""
        if(service == "KEYWORDS" || service == "CHANNELS" || service == "SENTIMENT")
        {
            var parameters:String=""
            let d="domain='"+settings.getDomain()!+"'"
            var k=""
            if(!filter.keywords.freetext.isEmpty  && filter.keywords.freetext_used)
            {
                k = "keywords='"+filter.keywords.freetext
            }
            for keyword in filter.keywords.keywords
            {
                
                if ( keyword.use)
                {
                    if(k=="")
                    {
                        k = "keywords='"+keyword.desc!
                    }
                    else
                    {
                        k = k + ","+keyword.desc!
                    }
                }
            }
            
            if(k == "")
            {
                k="keywords='*'"
            }
            else
            {
                k=k+"'"
            }
            
            
            
            //filter zeitraum
            let date_from="from_date=datetime'"+filter.zeitraum.dbbegin+"'"
            let date_to="to_date=datetime'"+filter.zeitraum.dbend+"'"
            
            var date_use=""
            if(filter.zeitraum.useFilter)
            {
                date_use="use_date=1"
            }
            else
            {
                date_use="use_date=0"
            }
            
            //filter channels
            var c=""
            for channel in filter.channels.channels
            {
                
                if ( channel.use)
                {
                    if(c=="")
                    {
                        c="channels='"+channel.desc!
                    }
                    else
                    {
                        c=c+","+channel.desc!
                    }
                    
                }
            }
            if(c == "")
            {
                c="channels='*'"
            }
            else
            {
                c=c+"'"
            }
            
           
            
            
            
            //filter sentiment
            
           
            var spos="";
            var sneg="";
            var sneu="";
            if ( filter.sentiment.positive)
            {
                spos="positive=1"
            }
            else
            {
                spos="positive=0"
            }
            
            if ( filter.sentiment.negative)
            {
                sneg="negative=1"
            }
            else
            {
                sneg="negative=0"
            }
            
            if ( filter.sentiment.neutral)
            {
                sneu="neutral=1"
            }
            else
            {
                sneu="neutral=0"
            }
            
           parameters="Parameters("+d+","+k+","+c+","+date_from+","+date_to+","+spos+","+sneg+","+sneu+","+date_use+")"
            url=settings.getUrl()!+"/comline/saa/services/app.xsodata/"+service+parameters.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!+"/Results?$format=json"
        }
        else
        {
           url=settings.getUrl()!+"/comline/saa/services/app.xsodata/"+service+"?$format=json"
        }
       
        
        //select
        var s=""
        if(select != "")
        {
            s="&$select="+select.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
        }
        
        
        
        var w:String="";
        
        //build filter
        if(addfilter != "")
        {
            w="&$filter="+addfilter.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
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
        connections -= 1
        if(connections == 0)
        {
            UIApplication.sharedApplication().networkActivityIndicatorVisible=false
        }
        // objc_sync_exit(connections)
        
        
        if(response != nil)
        {
            Debug.print("taskComplete::request "+response!.debugDescription)
            let httpresponse = response as? NSHTTPURLResponse
            
            if(httpresponse != nil)
            {
                if (httpresponse!.statusCode > 400 )
                {
                    var message:String="";
                    if (httpresponse!.statusCode == 401)
                    {
                        message=" Passwort ist falsch";
                    }
                    if(delegate == nil)
                    {
                        fatalError("Fehler Response Code "+httpresponse!.statusCode.description+message )
                    }
                    else
                    {
                        
                        Debug.print("Fehler Response Code \(httpresponse!.debugDescription)")
                        delegate?.errorByLoading(self, msg: "Connection Aborded with code \(httpresponse!.statusCode)")
                    }
                    return
                }
            }
            
        }
        if(error != nil)
        {
            Debug.print("taskComplete::error "+error!.debugDescription)
            if(delegate == nil)
            {
                fatalError("Fehler ")
            }
            else
            {
                Debug.print("task \(task?.state.rawValue)  canceling \(NSURLSessionTaskState.Canceling.rawValue))  error \(error!.code)")
                if( error!.code != -999 )
                {
                  delegate?.errorByLoading(self, msg: "\(error!.localizedDescription)")
                }
            }
            return
        }

        if( data == nil)
        {
            print("Error connecting: ")
            if(delegate == nil)
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
        
        
        
       // var anyError: NSErr
    
        do
        {
            jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
        }
        catch let error as NSError {
            Debug.print("taskComplete::json::error "+error.description)
        } catch {
            Debug.print("taskComplete::json unkown error ")
        }
        if( jsonDictionary == nil )
            {
                if(delegate == nil)
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
        let d = jsonDictionary!["d"] as! NSDictionary?
        
        if(d != nil)
        {
            
        Debug.print("BasicNetwork::refresh Type of d")
            dump(d)
            rawdata = d!["results"] as! NSArray?
        }
        
    }
    
    func updateData()
    {
        Debug.print("BasicNetwork::updateData")
        refresh()
        Debug.print("BasicNetwork::updateData  call delegate.dataLoaded")
        delegate?.dataLoaded(self)
    }
    
    var task:NSURLSessionDataTask?
    func getData(select:String,addfilter:String,top:String,orderby:String,service:String)
    {
        Debug.print("getData select \(select) addfilter \(addfilter) top \(top) orderby \(orderby) service \(service)")
        let url=makeURL(select,addfilter: addfilter,top: top,orderby: orderby,service: service)
        let jsonURL = NSURL(string: url)
        let sessionConfiguration = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let userPasswordString = settings.getLogin()!+":"+settings.getPassword()!
        let userPasswordData = userPasswordString.dataUsingEncoding(NSUTF8StringEncoding)
        Debug.print("PasswordData : "+userPasswordString)
        let base64EncodedCredential = userPasswordData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.EncodingEndLineWithCarriageReturn)
        let authString = "Basic \(base64EncodedCredential)"
        sessionConfiguration.HTTPAdditionalHeaders = ["Authorization" : authString]
        let session = NSURLSession(configuration: sessionConfiguration)
        if(task != nil && ( task?.state == NSURLSessionTaskState.Running || task?.state == NSURLSessionTaskState.Suspended) )
        {
            task!.cancel()
        }
        task = session.dataTaskWithURL(jsonURL!, completionHandler: taskComplete )
        
        
       // objc_sync_enter(connections)
        connections += 1
        if(connections > 0)
        {
            UIApplication.sharedApplication().networkActivityIndicatorVisible=true
        }
        //objc_sync_exit(connections)
        
        task!.resume()
    }
    

}