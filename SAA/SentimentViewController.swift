//
//  SentimentViewController.swift
//  SAA
//
//  Created by Thomas Nowak on 21.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class SentimentViewController: BaseViewController, CheckboxDelegate {
    var negative:CheckboxViewController
    var neutral:CheckboxViewController
    var positive:CheckboxViewController
    var filter:Filter
    init(filter:Filter){
        self.filter=filter
        var status:CheckBoxState
        if(filter.sentiment.negative)
        {
            status=CheckBoxState.SELECTED
        }
        else
        {
            status=CheckBoxState.UNSELECTED
        }
        
        negative=CheckboxViewController(status: status)
        
        
        if(filter.sentiment.neutral)
        {
            status=CheckBoxState.SELECTED
        }
        else
        {
            status=CheckBoxState.UNSELECTED
        }
        neutral=CheckboxViewController(status: status)
        if(filter.sentiment.positive)
        {
            status=CheckBoxState.SELECTED
        }
        else
        {
            status=CheckBoxState.UNSELECTED
        }
        positive=CheckboxViewController(status: status)
        
        
        super.init()
        negative.text="Negativ"
        positive.text="Positiv"
        neutral.text="Neutral"
        negative.delegate=self
        positive.delegate=self
        neutral.delegate=self
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func checkboxStateChanged(sender: CheckboxViewController, state: CheckBoxState)
    {
        Debug.print("\(self) sender \(sender) state \(state)")
        if(sender == positive)
        {
            if(state != CheckBoxState.DISABLE)
            {
                if(state == CheckBoxState.SELECTED)
                {
                    filter.sentiment.positive=true
                }
                else
                {
                    filter.sentiment.positive=false
                }
            }
            
        }
        if(sender == negative)
        {
            if(state != CheckBoxState.DISABLE)
            {
                if(state == CheckBoxState.SELECTED)
                {
                    filter.sentiment.negative=true
                }
                else
                {
                    filter.sentiment.negative=false
                }
            }
            
        }
        if(sender == neutral)
        {
            if(state != CheckBoxState.DISABLE)
            {
                if(state == CheckBoxState.SELECTED)
                {
                    filter.sentiment.neutral=true
                }
                else
                {
                    filter.sentiment.neutral=false
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(positive)
        addChild(negative)
        addChild(neutral)
        view.translatesAutoresizingMaskIntoConstraints=false
    //view.backgroundColor=UIColor.yellowColor()
        positive.view.translatesAutoresizingMaskIntoConstraints=false
        negative.view.translatesAutoresizingMaskIntoConstraints=false
        neutral.view.translatesAutoresizingMaskIntoConstraints=false
        setConstraints()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setConstraints()
    {
        Debug.print("\(self.description)::setConstraints")
    var constraints:[NSLayoutConstraint] = [
    
    
    NSLayoutConstraint(item: positive.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
    NSLayoutConstraint(item:positive.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
        
        
        NSLayoutConstraint(item:positive.view,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 0),
    NSLayoutConstraint(item:positive.view,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 1.0/3.0,constant: 0),
    ]
        view.addConstraints(constraints)
        constraints = [
    NSLayoutConstraint(item: negative.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
    NSLayoutConstraint(item: negative.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: positive.view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 0),
        NSLayoutConstraint(item:negative.view,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 0),
        NSLayoutConstraint(item:negative.view,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 1.0/3.0,constant: 0),
        ]
        view.addConstraints(constraints)
        constraints = [
    NSLayoutConstraint(item: neutral.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
        NSLayoutConstraint(item: neutral.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: negative.view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 0),
        NSLayoutConstraint(item:neutral.view,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 0),
        NSLayoutConstraint(item:neutral.view,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 1.0/3.0,constant: 0),
    
    
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
