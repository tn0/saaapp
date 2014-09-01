//
//  CanalViewController.swift
//  SAA
//
//  Created by Thomas Nowak on 16.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class CanalViewController: LeftFilterViewController {

    var channels:UIView
    var labelArray=[]
    var filter:Filter
    init(filter:Filter) {
        channels=UIView()
        self.filter=filter
        channels.setTranslatesAutoresizingMaskIntoConstraints(false)
        super.init(nibName: nil, bundle: nil)
        button.text="< Kanal"
        pane = 1
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        content.addSubview(channels)
         setConstraints()
        showChannels()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showChannels()
    {
        for view in channels.subviews
        {
            view.removeFromSuperview()
        }
        var constraints=channels.constraints()
        channels.removeConstraints(constraints)
        var i=0
        var constr1:NSLayoutConstraint;
        var oldLabel:UILabel?
        for c in filter.channels.channels
        {
            if(c.use)
            {
                var label=UILabel()
                label.setTranslatesAutoresizingMaskIntoConstraints(false)
                label.text=c.name
                label.textColor=Colors.zeitraumLabelTextColor
                channels.addSubview(label)
                
                if(i==0)
                {
                    constr1=NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: channels,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0)
                    
                }
                else
                {
                    constr1=NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: oldLabel!,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 20)
                }
                var constr2=NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: channels,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0)
                channels.addConstraint(constr1)
                channels.addConstraint(constr2)
                oldLabel=label;
                i++
            }
        }
        if(i==0)
        {
            var label=UILabel()
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            label.text="Alle Kanäle"
            label.textColor=Colors.zeitraumLabelTextColor
            channels.addSubview(label)
            
            constr1=NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: channels,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0)
                
            
            var constr2=NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: channels,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0)
            channels.addConstraint(constr1)
            channels.addConstraint(constr2)
        }
    }
    
    
    override func updateDisplay()
    {
        super.updateDisplay()
        showChannels()
    }
    
    override func setConstraints() {
        
        Debug.print("setConstraints in KeywordsController")
        var constraints = [
            
            
            NSLayoutConstraint(item:channels,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: content,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:channels,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: content,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            
        ]
        content.addConstraints(constraints)
        super.setConstraints()
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
