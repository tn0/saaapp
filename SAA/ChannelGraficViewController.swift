//
//  ChannelGraficViewController.swift
//  SAA
//
//  Created by Thomas Nowak on 23.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class ChannelGraficViewController: BaseGraficViewController,NewDataDelegate {

    var beitrag:UILabel
    var anzahl:UILabel
    var content:UIView
    
    init(filter:Filter)
    {
        
        beitrag=UILabel()
        beitrag.setTranslatesAutoresizingMaskIntoConstraints(false)
        beitrag.textColor=Colors.leftMenuInactiveTextColor
        
        anzahl=UILabel()
        anzahl.setTranslatesAutoresizingMaskIntoConstraints(false)
        anzahl.textColor=Colors.leftMenuInactiveTextColor
        content=UIView()
        content.setTranslatesAutoresizingMaskIntoConstraints(false)
        super.init()
        dataSource=ChannelData(filter:filter)
          dataSource!.delegate=self
       // content.backgroundColor=UIColor.redColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        beitrag.text="Beiträge"
        anzahl.textAlignment=NSTextAlignment.Right
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(beitrag)
        view.addSubview(anzahl)
        view.addSubview(content)
        setConstraints()
    }
    
    override func dataLoaded(sender: BasicNetwork)
    {
        removeAllSubViewsfromView(content)
        var constr=content.constraints()
        content.removeConstraints(constr)
        Debug.print("\(self) Data Loaded update grafic")
        var source:ChannelData=dataSource as ChannelData
        var max=source.maxMessages
        
        anzahl.text="\(source.sumOfMessages)"
        if( source.data?.count > 7)
        {
            
        }
        else
        {
            var i=1
            var oldcontroller:BarViewController?
            for  item in source.data!
            {
                var model=item as ChannelModel
                var controller=BarViewController(name: model.name,anz: model.messages,max: max)
                addChildToSubView(controller,view: content)
                var constr1:NSLayoutConstraint
                if(i==1)
                {
                    constr1=NSLayoutConstraint(item: controller.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: content,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0)
                }
                else
                {
                    constr1=NSLayoutConstraint(item: controller.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: oldcontroller!.view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 10)
                }
                var constr2=NSLayoutConstraint(item: controller.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: content,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 10)
                var constr3=NSLayoutConstraint(item: controller.view,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: content,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: -10)
                var constr4=NSLayoutConstraint(item: controller.view,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: content,attribute: NSLayoutAttribute.Height,multiplier: 1.0/7.0,constant: -60.0 / 7.0)
                content.addConstraint(constr1)
                content.addConstraint(constr2)
                content.addConstraint(constr3)
                content.addConstraint(constr4)
                oldcontroller=controller
                i++
            }
        }
       
        
        
        
    }
    
    func getData()
    {
        dataSource?.getData()
    }
    
    
    func setConstraints()
    {
        Debug.print("\(self.description)::setConstraints")
        var constraints = [
            
            
            NSLayoutConstraint(item: beitrag,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: beitrag,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 10),
            
            
            NSLayoutConstraint(item:anzahl,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:anzahl,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: -10),
            
            NSLayoutConstraint(item:content,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: beitrag,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 25),
            NSLayoutConstraint(item:content,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 5),
            NSLayoutConstraint(item:content,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: -5),
            NSLayoutConstraint(item:content,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: -20),
            
            
        ]
        view.addConstraints(constraints)
        
    }
    
    
}
