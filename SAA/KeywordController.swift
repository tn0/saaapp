//
//  KeywordController.swift
//  SAA
//
//  Created by Thomas Nowak on 14.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class KeywordController: LeftFilterViewController {

    var keywords:UIView
    var filter:Filter
    init(filter:Filter) {
        keywords=UIView()
        self.filter=filter
        keywords.translatesAutoresizingMaskIntoConstraints=false;
        
        
        
        super.init()
        button.text="< Schlüsselworte"
        pane=2
        // Initialization code here.
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=Colors.zeitraumBackgroundColor;
        
        
        content.addSubview(keywords)
        
        setConstraints()
        showKeywords()
        
    }
    func showKeywords()
    {
        for view in keywords.subviews
        {
            view.removeFromSuperview()
        }
        let constraints:[NSLayoutConstraint]=keywords.constraints
        keywords.removeConstraints(constraints)
        var i=0
        var constr1:NSLayoutConstraint;
        var oldLabel:UILabel?
        if(filter.keywords.freetext != "" && filter.keywords._freetext_used)
        {
            let label=UILabel()
            label.translatesAutoresizingMaskIntoConstraints=false
            label.text=filter.keywords.freetext
            label.textColor=Colors.zeitraumLabelTextColor
            keywords.addSubview(label)
            
            constr1=NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: keywords,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0)
            
            let constr2=NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: keywords,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0)
            keywords.addConstraint(constr1)
            keywords.addConstraint(constr2)
            oldLabel=label;
            i+=1
        }
        for c in filter.keywords.keywords
        {
            if(c.use)
            {
                let label=UILabel()
                label.translatesAutoresizingMaskIntoConstraints=false
                label.text=c.name
                label.textColor=Colors.zeitraumLabelTextColor
                keywords.addSubview(label)
                
                if(i==0)
                {
                    constr1=NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: keywords,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0)
                    
                }
                else
                {
                    constr1=NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: oldLabel!,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 20)
                }
                let constr2=NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: keywords,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0)
                keywords.addConstraint(constr1)
                keywords.addConstraint(constr2)
                oldLabel=label;
                i+=1
            }
        }
        if(i==0)
        {
            let label=UILabel()
            label.translatesAutoresizingMaskIntoConstraints=false
            label.text="Alle Beiträge"
            label.textColor=Colors.zeitraumLabelTextColor
            keywords.addSubview(label)
            
            constr1=NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: keywords,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0)
            
            
            let constr2=NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: keywords,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0)
            keywords.addConstraint(constr1)
            keywords.addConstraint(constr2)
        }
    }
    
    override func updateDisplay()
    {
        super.updateDisplay()
        showKeywords()
    }
    
    override func setConstraints() {
        
        Debug.print("setConstraints in KeywordsController")
        let constraints:[NSLayoutConstraint] = [
            
            
            NSLayoutConstraint(item: keywords,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: content,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:keywords,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: content,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            
        ]
        content.addConstraints(constraints)
        super.setConstraints()
    }
}
