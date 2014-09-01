//
//  ConfigCanalsViewController.swift
//  SAA
//
//  Created by Thomas Nowak on 17.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class ConfigKeywordsViewController: BaseConfigViewController , CheckboxDelegate{
    
    var keywords:UIView
    override init(_filter: Filter)  {
        keywords=UIView();
        keywords.setTranslatesAutoresizingMaskIntoConstraints(false)
        super.init(_filter: _filter)
        
        // Do any additional setup after loading the view.
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func checkboxStateChanged(sender: CheckboxViewController, state: CheckBoxState)
    {
        Debug.print("ConfigCannles::checkbocStateChanged \(sender) \(state)")
        var name=sender.text
        for f in filter.keywords.keywords
        {
            if (f.name == name )
            {
                if(state == CheckBoxState.SELECTED)
                {
                    f.use=true
                }
                else
                {
                    f.use=false
                }
            }
        }
        showKeywords()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.addSubview(keywords)
        
        setConstraints()
        showKeywords()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showKeywords()
    {
        removeAllChilds()
        var constraints=keywords.constraints()
        keywords.removeConstraints(constraints)
        var i=0
        var constr1:NSLayoutConstraint;
        var oldView:UIView?
        var status:CheckBoxState
        Debug.print("Filter \(filter)")
        for c in filter.keywords.keywords
        {
            if(c.use)
            {
                status=CheckBoxState.SELECTED
            }
            else
            {
                status=CheckBoxState.UNSELECTED
            }
            var checkbox=CheckboxViewController(status: status)
            checkbox.text=c.name
            checkbox.delegate=self
            
            addChildToSubView(checkbox, view: keywords)
            
            if(i==0)
            {
                constr1=NSLayoutConstraint(item:checkbox.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: keywords,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0)
                
            }
            else
            {
                constr1=NSLayoutConstraint(item:checkbox.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: oldView!,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 40)
            }
            var constr2=NSLayoutConstraint(item:checkbox.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: keywords,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0)
            var constr3=NSLayoutConstraint(item:checkbox.view,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 60)
            var constr4=NSLayoutConstraint(item:checkbox.view,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: keywords,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 0)
            keywords.addConstraint(constr1)
            keywords.addConstraint(constr2)
            keywords.addConstraint(constr3)
            keywords.addConstraint(constr4)
            oldView=checkbox.view;
            i++
        }
    }
    func setConstraints() {
        
        Debug.print("setConstraints in KeywordsController")
        var constraints = [
            
            
            NSLayoutConstraint(item:keywords,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:keywords,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:keywords,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:keywords,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 0),
            
        ]
        view.addConstraints(constraints)
        
    }
}



