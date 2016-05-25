//
//  KeywordsTableViewController.swift
//  SAA
//
//  Created by Thomas Nowak on 24.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class KeywordTableViewController: BaseGraficViewController {
    
    var label:UILabel
    var content:UIView
    
    var keywords=[
    UILabel(),
    UILabel(),
        UILabel(),
        UILabel(),
        UILabel()
    ]
    
    init(filter:Filter)
    {
        
        label=UILabel()
        label.translatesAutoresizingMaskIntoConstraints=false
        
        content=UIView()
        content.translatesAutoresizingMaskIntoConstraints=false
        
        super.init()
        dataSource=KeywordData(filter:filter)
        dataSource!.delegate=self
        
        // content.backgroundColor=UIColor.redColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpKeywords()
    {
        var old:UILabel?
        var i:Int=0
        for label in keywords
        {
            label.translatesAutoresizingMaskIntoConstraints=false
            label.font=UIFont.boldSystemFontOfSize(UIFont.systemFontSize())
            label.textAlignment=NSTextAlignment.Right
            label.textColor=Colors.channelGraficBarColor
                label.text=""
            content.addSubview(label)
            var constraints:[NSLayoutConstraint]
            if(i==0)
            {
                constraints = [
                    NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: content,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 10),
                    NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: content,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 8),
                    NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: content,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: -10),
                    //NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: -20),
                ]
               
            }
            else
            {
                
                constraints = [
                    NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: old!,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 20),
                    NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: content,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 8),
                    NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: content,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: -10),
                    //NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: -20),
                ]
            }
             content.addConstraints(constraints)
            old=label
            i += 1
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        label.text="Top-Begriffe"
        label.textColor=Colors.leftMenuInactiveTextColor
        view.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(label)
        view.addSubview(content)
        content.layer.borderColor=Colors.grafikBorderColor.CGColor
        content.layer.borderWidth=1
        content.layer.cornerRadius=5
        setConstraints()
        setUpKeywords()
    }
    
    override func dataLoaded(sender: BasicNetwork)
    {
        
        
        
        refresh()
        
        
        
        
    }
    
    func refresh()
    {
        let source:KeywordData=dataSource as! KeywordData
        
        
        var i:Int=0
        let l=source.data!.count
        for label in keywords
        {
            if( i < l)
            {
            label.text=source.data![i] as? String
            }
            else
            {
            label.text=""
            }
            
            i += 1
        }
        
    }
    
    func getData()
    {
        dataSource!.getData()
    }
    
    func setConstraints()
    {
        Debug.print("\(self.description)::setConstraints")
        var constraints:[NSLayoutConstraint] = [
            
            
            NSLayoutConstraint(item: label,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: label,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 10),
            ]
        view.addConstraints(constraints)
        
        constraints = [
            NSLayoutConstraint(item:content,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: label,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 23),
            NSLayoutConstraint(item:content,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 2),
            NSLayoutConstraint(item:content,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: -3),
            NSLayoutConstraint(item:content,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: -18),
        ]
        view.addConstraints(constraints)
        
    }
    
    
}
