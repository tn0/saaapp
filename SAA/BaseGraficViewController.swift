//
//  BaseGraficViewController.swift
//  SAA
//
//  Created by Thomas Nowak on 23.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class BaseGraficViewController: BaseViewController, NewDataDelegate {
    
    var dataSource:BasicNetwork?
    override init()
    {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func dataLoaded(sender: BasicNetwork)
    {
       Debug.print("\(self) please override the dataLoaded method oh BaseGraficViewController to update your grafic")
    }
    
    func errorByLoading(sender: BasicNetwork, msg: String) {
        
        Debug.print("\(self) Netzwerkfehler "+msg)
        NSOperationQueue.mainQueue().addOperationWithBlock {
            if(!Errorlock.showError)
            {
                self.showAlert(msg)
            }
        }
        
        
    }
    
    var errorAlert: UIAlertView?
    func showAlert(msg:String){
        Errorlock.showError=true
        Debug.print("errorAlert \(errorAlert?.debugDescription)")
        if(errorAlert? == nil)
        {
        Debug.print("new errorAlert \(errorAlert?.debugDescription)")
            errorAlert = UIAlertView()
        Debug.print("new errorAlert \(errorAlert?.debugDescription)")
        errorAlert!.delegate = self
        
        errorAlert!.title = "Fehler"
        errorAlert!.message = msg
        errorAlert!.addButtonWithTitle("OK")
        
        Debug.print("show errorAlert \(errorAlert?.debugDescription)")
        errorAlert!.show()
        }
        
    }
    
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
        errorAlert=nil
        Errorlock.showError=false
        Debug.print("del errorAlert \(errorAlert?.debugDescription)")
        switch buttonIndex{
            
        case 1:
            NSLog("Retry");
            break;
        case 0:
            NSLog("Dismiss");
            break;
        default:
            NSLog("Default");
            break;
            //Some code here..
            
        }
    }
}
