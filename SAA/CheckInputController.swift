//
//  CheckInput.swift
//  SAA
//
//  Created by Thomas Nowak on 16.9.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import Foundation
import UIKit

class CheckInputController: BaseViewController {
    var box:Checkbox
    var label:UITextField
    var filter:Filter
    
    var text:String {
        get {
            return label.text!
        }
        set {
            label.text=newValue
            
        }
    }
    
    var status:CheckBoxState {
        get {
            return box.status
        }
        set {
            box.status=newValue
        }
    }
    init(filter:Filter)
    {
        Debug.print("CheckInputController::init")
        self.filter=filter
        
        
        if(filter.keywords.freetext_used)
        {
            box=Checkbox(status: CheckBoxState.SELECTED)
        }
        else
        {
            box=Checkbox(status: CheckBoxState.UNSELECTED)
        }
        
        box.setTranslatesAutoresizingMaskIntoConstraints(false)
        label=UITextField()
        label.font=UIFont.systemFontOfSize(UIFont.systemFontSize()*1.1)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.backgroundColor=UIColor.whiteColor()
        label.textColor=UIColor.darkTextColor()
        label.text=filter.keywords.freetext
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        Debug.print("CheckInputController::viewDidLoad")
        super.viewDidLoad()
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(box)
        view.addSubview(label)
        box.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        var tapRecognizer=UITapGestureRecognizer(target: self, action: "stateChanged:")
        tapRecognizer.numberOfTapsRequired=1;
        tapRecognizer.numberOfTouchesRequired=1;
        view.addGestureRecognizer(tapRecognizer)
        
        box.addTarget(self, action: "stateChanged:", forControlEvents: UIControlEvents.TouchDown)
        label.addTarget(self,action: "textFieldChanged:", forControlEvents: UIControlEvents.EditingChanged)
        setConstraints()
        
    }
    
    
    func textFieldChanged(field:UITextField)
    {
        if(field.text.isEmpty)
        {
            status=CheckBoxState.UNSELECTED
        }
        else
        {
            status=CheckBoxState.SELECTED
        }
        filter.keywords.freetext=field.text
    }
    
    func stateChanged(c: AnyObject ) {
        
        Debug.print("CheckInputController::View touched")
        if( status != CheckBoxState.DISABLE)
        {
            if(status == CheckBoxState.UNSELECTED)
            {
                status=CheckBoxState.SELECTED
                filter.keywords.freetext_used=true
            }
            else
            {
                status=CheckBoxState.UNSELECTED
                filter.keywords.freetext_used=false
            }
           // delegate?.checkboxStateChanged(self,state: status);
        }
        
        
    }
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        Debug.print(" \(self.description) ---> View \(view.frame) box \(box.frame) label \(label.frame) ")
    }
    
    func setConstraints()
    {
        Debug.print("setConstraints in CheckInputController")
        var constraints = [
            NSLayoutConstraint(item: box,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: box,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: box, attribute:NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem:nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 30),
            NSLayoutConstraint(item: box, attribute:NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem:nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 30),
            NSLayoutConstraint(item: label,attribute: NSLayoutAttribute.CenterY,relatedBy: NSLayoutRelation.Equal,toItem: box,attribute: NSLayoutAttribute.CenterY,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: label,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: box,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 5),
            NSLayoutConstraint(item: label, attribute:NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem:view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: label, attribute:NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem:nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 20),
            
            
        ]
        view.addConstraints(constraints)
        
    }
}