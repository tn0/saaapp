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
        return getStringfromKey(SettingKey.URL.toRaw())
    }
    func getLogin()->String?
    {
        return getStringfromKey(SettingKey.LOGIN.toRaw())
    }
    func getPassword()->String?
    {
        return getStringfromKey(SettingKey.PASSWORD.toRaw())
    }
    func getDomain()->String?
    {
        return getStringfromKey(SettingKey.DOMAIN.toRaw())
    }
    
    func loadDefault()
    {
        var bundle=NSBundle.mainBundle()
        Debug.print("bundle"+bundle.debugDescription)
        var rootFileName=bundle.pathForResource("Settings.bundle/Root.plist", ofType: nil)
        
        if(rootFileName != nil)
        {
            Debug.print("rootFileName "+rootFileName!)
            var dic = NSDictionary(contentsOfFile: rootFileName!)
            var prefKey:NSString=NSString(string: "PreferenceSpecifiers")
            var pref=dic[prefKey] as NSArray
            var appDefault:NSMutableDictionary=NSMutableDictionary()
            for item in pref
            {
                Debug.print("item "+item.debugDescription!)
                var i=item as NSDictionary
                
                Debug.print("i "+i.debugDescription!)
                var k:NSString=NSString(string: "Key")
                
                Debug.print("k "+k.debugDescription!)
                var key: String?=i[k] as String?
                if( key != nil )
                {
                Debug.print("key "+key.debugDescription)
                var val: AnyObject? = i[NSString(string: "DefaultValue")]
                
                    if( val != nil)
                    {
                        Debug.print("val "+val.debugDescription)
                        Debug.print("Setting Defaults: Key " + key! + " value " + val.debugDescription)
                        appDefault.setValue(val!, forKey: key!)
                    }
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
        if(result? == nil)
        {
            loadDefault()
            result = NSUserDefaults.standardUserDefaults().stringForKey(key)
        }
        return result
    }
}