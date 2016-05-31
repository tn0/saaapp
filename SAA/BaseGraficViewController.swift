//
//  BaseGraficViewController.swift
//  SAA
//
//  Created by Thomas Nowak on 23.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class BaseGraficViewController: BaseViewController, NewDataDelegate
{
//class BaseGraficViewController: BaseViewController {
    
    var dataSource:BasicNetwork?
    override init()
    {
        Debug.print("BaseGraficViewController::init")
        super.init()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func dataLoaded(sender: BasicNetwork)
    {
       Debug.print("\(self) please override the dataLoaded method oh BaseGraficViewController to update your grafic")
    }
    
    func errorByLoading(sender: BasicNetwork, msg: String)
    {
        
        Debug.print("\(self) Netzwerkfehler "+msg)
        NSOperationQueue.mainQueue().addOperationWithBlock
        {
            if(!Errorlock.showError)
            {
                self.showAlert(msg)
            }
        }
    }
    
    func showAlert(msg:String)
    {
        
        Errorlock.showError=true
        let retry:UIAlertAction=UIAlertAction(title: "OK", style: .Default)
        { _ in
            NSLog("OK");
            Errorlock.showError=false
        }
        
        let alert = UIAlertController(title: "Netzwerkfehler!", message:msg, preferredStyle: .Alert)
        alert.addAction(retry)
        self.presentViewController(alert, animated: true){}
        
    }
}