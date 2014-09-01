//
//  ConfigFilterViewController.swift
//  SAA
//
//  Created by Thomas Nowak on 16.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit
import Foundation

class ConfigFilterViewController: BaseViewController {

    var pane:Int
    var filter:Filter
    var button:UIButton
    var delegate: FilterDelegate?;
    
    var zeitraumButton:MenuButton;
    var canalsButton:MenuButton;
    var keywordsButton:MenuButton;
    
    var curController:UIViewController?
    var curConstraints=[]
    
    init(pane:Int,filter :Filter){
        self.pane=pane
        self.filter=filter
        button=UIButton()
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.setTitle("OK", forState:UIControlState.Normal)
        button.backgroundColor=Colors.FilterOKButtonBackgroundColor
        button.tintColor=UIColor.lightGrayColor()
        
        zeitraumButton=MenuButton(frame: CGRect())
        zeitraumButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        zeitraumButton.setTitle("Zeitraum", forState:UIControlState.Normal)
        
        canalsButton=MenuButton(frame: CGRect())
        canalsButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        canalsButton.setTitle("Kanal", forState:UIControlState.Normal)
        
        keywordsButton=MenuButton(frame: CGRect())
        keywordsButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        keywordsButton.setTitle("Schlüsselworte", forState:UIControlState.Normal)
        
        
        
        
        
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.addTarget(self, action: "tappedButton:", forControlEvents: UIControlEvents.TouchDown)
        zeitraumButton.addTarget(self, action: "zeitraum:",  forControlEvents: UIControlEvents.TouchDown)
        canalsButton.addTarget(self, action: "canals:",  forControlEvents: UIControlEvents.TouchDown)
        keywordsButton.addTarget(self, action: "keywords:",  forControlEvents: UIControlEvents.TouchDown)
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.backgroundColor=Colors.configPaneBackgroundColor
        view.addSubview(button)
        view.addSubview(zeitraumButton)
        view.addSubview(canalsButton)
        view.addSubview(keywordsButton)
        setConstraints()
        showPane()
        // Do any additional setup after loading the view.
    }
    
    func showPane()
    {
        zeitraumButton.active=false;
        canalsButton.active=false;
        keywordsButton.active=false;
        removeController()
        switch(pane)
        {
            case 0: zeitraumButton.active=true;
                curController=ConfigZeitraumViewController(_filter: filter)
            
            case 1: canalsButton.active=true;
            curController=ConfigCanalsViewController(_filter: filter)
            
            case 2: keywordsButton.active=true;
            curController=ConfigKeywordsViewController(_filter: filter)
            
            default: Debug.print("unkown pane")
        }
        addController()
    }
    
    func zeitraum(sender: UIButton)
    {
        if(pane != 0)
        {
        pane=0;
        showPane();
        }
        
    }

    func canals(sender: UIButton)
    {
        if(pane != 1)
        {
        pane=1;
        showPane();
        }
    }
    
    func keywords(sender: UIButton)
    {
        if(pane != 2)
        {
        pane=2;
            showPane();
        }

    }
    
    func removeController()
    {
        if(curController? != nil)
        {
            view.removeConstraints(curConstraints)
            removeChild(curController!)
        }
    }
    
    func addController()
    {
        if(curController? != nil)
        {
            addChild(curController!)
            curConstraints=[
                NSLayoutConstraint(item: curController!.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: zeitraumButton,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 20),
                NSLayoutConstraint(item: curController!.view,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: button,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: -20),
                NSLayoutConstraint(item: curController!.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 20),
                NSLayoutConstraint(item: curController!.view,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: -20),
            ]
            view.addConstraints(curConstraints)
        }
    }
    
    func tappedButton(sender: UIButton)
    {
        delegate?.showFilter()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setConstraints()
    {
        Debug.print("\(self.description)::setConstraints")
    var constraints = [
        NSLayoutConstraint(item: button,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: -20),
        NSLayoutConstraint(item: button,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 20),
        NSLayoutConstraint(item: button,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: -20),
        
        NSLayoutConstraint(item: zeitraumButton,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
        NSLayoutConstraint(item: zeitraumButton,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
        NSLayoutConstraint(item: zeitraumButton,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 1.0/3.0,constant: -10),
        
        NSLayoutConstraint(item: canalsButton,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
        NSLayoutConstraint(item: canalsButton,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: zeitraumButton,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 0),
        NSLayoutConstraint(item: canalsButton,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 1.0/3.0,constant: -30),
        
        NSLayoutConstraint(item: keywordsButton,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
        NSLayoutConstraint(item: keywordsButton,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: canalsButton,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 0),
        NSLayoutConstraint(item: keywordsButton,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 1.0/3.0,constant:+40),
    ]
        view.addConstraints(constraints)

    }
    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
