//
//  Settings.swift
//  SAA
//
//  Created by Thomas Nowak on 23.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import Foundation
class Settings
{
    init()
    {
        
    }
    func getUrl()->String?
    {
        return getStringfromKey(SettingKey.URL.rawValue)
    }
    func getLogin()->String?
    {
        return getStringfromKey(SettingKey.LOGIN.rawValue)
    }
    func getPassword()->String?
    {
        return getStringfromKey(SettingKey.PASSWORD.rawValue)
    }
    func getDomain()->String?
    {
        return getStringfromKey(SettingKey.DOMAIN.rawValue)
    }
    
    func getCustomer()->String?
    {
        return getStringfromKey(SettingKey.CUSTOMER.rawValue)
    }
    func loadDefault()
    {
        let bundle=NSBundle.mainBundle()
        Debug.print("bundle"+bundle.debugDescription)
        let rootFileName=bundle.pathForResource("Settings.bundle/Root.plist", ofType: nil)
        
        if(rootFileName != nil)
        {
            Debug.print("rootFileName "+rootFileName!)
            let dic = NSDictionary(contentsOfFile: rootFileName!)
            let prefKey:NSString=NSString(string: "PreferenceSpecifiers")
            let pref=dic![prefKey] as! NSArray
            var appDefault:[String:AnyObject]=[:]
            for item in pref
            {
                Debug.print("item "+item.debugDescription!)
                let i=item as! NSDictionary
                /*
                Debug.print("i "+i.debugDescription)
                let k:NSString=NSString(string: "Key")
                
                Debug.print("k "+k.debugDescription)
                */
                let key=i.objectForKey(NSString(string: "Key")) as? String
                let val=i.objectForKey(NSString(string: "DefaultValue")) as? String
                if  key != nil && !key!.containsString("") && val != nil
                {
                    appDefault[key!]=val;
                }
            }
            Debug.print("Default Settings: \(appDefault)")
            NSUserDefaults.standardUserDefaults().registerDefaults(appDefault)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        else
        {
            Debug.print("Settings.bundle/Root.plist not found!")
        }
        
    }
    
    func getStringfromKey(key:String) -> String?
    {
        var result:String? = NSUserDefaults.standardUserDefaults().stringForKey(key)
        if(result == nil)
        {
            loadDefault()
            result = NSUserDefaults.standardUserDefaults().stringForKey(key)
        }
        return result
    }
}