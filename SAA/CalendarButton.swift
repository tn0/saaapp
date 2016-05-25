//
//  CalendarButton.swift
//  SAA
//
//  Created by Thomas Nowak on 17.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class CalendarButton: UIButton {

    var day:Int=1
    var _enable:Bool=true
    var _active:Bool=true
    
    var enable:Bool {
    get {
        return _enable;
    }
    set {
        _enable=newValue
        if(_enable)
        {
            backgroundColor=Colors.calendarButtonInactiveBackgroundColor
            setTitleColor(Colors.calendarButtonInactiveTintColor, forState: UIControlState.Normal)
            layer.borderColor=Colors.calendarButtonInactiveBorderColor.CGColor
            
            
        }
        else
        {
            _active=false;
            backgroundColor=Colors.calendarButtonDisableBackgroundColor
            setTitleColor(Colors.calendarButtonDisableTintColor, forState: UIControlState.Normal)
            layer.borderColor=Colors.calendarButtonDisableBorderColor.CGColor
        }
    }
    
    }
    
    var active:Bool {
    get {
        return _active;
    }
    set {
        if(_enable)
        {
        _active=newValue
        if(_active)
        {
            backgroundColor=Colors.calendarButtonActiveBackgroundColor
            setTitleColor(Colors.calendarButtonActiveTintColor, forState: UIControlState.Normal)
            
             layer.borderColor=Colors.calendarButtonActiveBorderColor.CGColor
        }
        else
        {
            backgroundColor=Colors.calendarButtonInactiveBackgroundColor
            setTitleColor(Colors.calendarButtonInactiveTintColor, forState: UIControlState.Normal)
            
            layer.borderColor=Colors.calendarButtonInactiveBorderColor.CGColor
        }
        }
    }
    
    }
    init() {
        let frame=CGRect(x: 0, y: 0, width: 60, height: 60)
        super.init(frame: frame)
        self.setTitle("", forState: UIControlState.Normal)
        enable=false
        layer.cornerRadius=9
        layer.borderWidth=1
        // Initialization code
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

}
