//
//  CheckboxViewController.swift
//  SAA
//
//  Created by Thomas Nowak on 21.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class CheckboxViewController: BaseViewController {
    var box:Checkbox
    var label:UILabel
    var delegate: CheckboxDelegate?;
    
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
        if(status==CheckBoxState.SELECTED)
        {
            label.textColor=Colors.checkboxSelectedColor
        }
        else
        {
            label.textColor=Colors.checkboxUnselectedColor
        }
    }
    }
    init(status:CheckBoxState)
    {
        Debug.print("CheckboxViewController::init")
        box=Checkbox(status: status)
        box.setTranslatesAutoresizingMaskIntoConstraints(false)
        label=UILabel()
        label.font=UIFont.systemFontOfSize(UIFont.systemFontSize()*1.1)
        if(status==CheckBoxState.SELECTED)
        {
            label.textColor=Colors.checkboxSelectedColor
        }
        else
        {
            label.textColor=Colors.checkboxUnselectedColor
        }
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        Debug.print("CheckboxViewController::viewDidLoad")
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
        setConstraints()
    }
    
    func stateChanged(c: AnyObject ) {
        
        Debug.print("CheckboxViewController::View touched")
        if( status != CheckBoxState.DISABLE)
        {
            if(status == CheckBoxState.UNSELECTED)
            {
              status=CheckBoxState.SELECTED
            }
            else
            {
              status=CheckBoxState.UNSELECTED
            }
            delegate?.checkboxStateChanged(self,state: status);
        }
        
        
    }
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        Debug.print(" \(self.description) ---> View \(view.frame) box \(box.frame) label \(label.frame) ")
    }
    
    func setConstraints()
    {
        Debug.print("setConstraints in CheckboxViewController")
        var constraints = [
            NSLayoutConstraint(item: box,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: box,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: box, attribute:NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem:nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 30),
            NSLayoutConstraint(item: box, attribute:NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem:nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 30),
            NSLayoutConstraint(item: label,attribute: NSLayoutAttribute.CenterY,relatedBy: NSLayoutRelation.Equal,toItem: box,attribute: NSLayoutAttribute.CenterY,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: label,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: box,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 5),
            NSLayoutConstraint(item: label, attribute:NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.GreaterThanOrEqual,toItem:nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 100),
            NSLayoutConstraint(item: label, attribute:NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem:nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 20),
            
            
        ]
        view.addConstraints(constraints)

    }
}
