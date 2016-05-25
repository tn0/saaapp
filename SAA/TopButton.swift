//
//  TopButton.swift
//  SAA
//
//  Created by Thomas Nowak on 2.9.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class TopButton: UIButton {
    
    
    override var selected:Bool
        {
        get
        {
            return super.selected
        }
        set
        {
            super.selected=newValue
            setBackgroundColor()
        }
    }
    
    override var enabled:Bool
        {
        get
        {
            return super.enabled
        }
        set
        {
            super.enabled=newValue
            setBackgroundColor()
        }
    }
    func setBackgroundColor()
    {
        if(enabled)
        {
            if(selected)
            {
                backgroundColor=Colors.topButtonSelectedBackgroundColor
                
            }
            else
            {
                backgroundColor=Colors.topButtonBackgroundColor
            }
        }
        else
        {
            backgroundColor=Colors.topButtonDisabeledBackgroundColor
        }
    }
    
     init() {
        let f=CGRect()
        super.init(frame: f)
        setTitleColor(Colors.topButtonSelectedTitleColor, forState: UIControlState.Selected)
        setTitleColor(Colors.topButtonDisabeledTitleColor, forState: UIControlState.Disabled)
        setTitleColor(Colors.topButtonTitleColor, forState: UIControlState.Normal)
        layer.cornerRadius=5
        contentEdgeInsets=UIEdgeInsets(top: 5.0,left: 10.0,bottom: 5.0,right: 10.0)
        invalidateIntrinsicContentSize()
        
        //layoutMargins=UIEdgeInsets(top: 10.0,left: 10.0,bottom: 10.0,right: 10.0)
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
