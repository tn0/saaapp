//
//  MenuButton.swift
//  SAA
//
//  Created by Thomas Nowak on 16.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit
import CoreGraphics

class MenuButton: UIButton {
    var _active:Bool
    var active:Bool
    {
    get {
        return _active
    }
    set {
        _active=newValue
        if(newValue)
        {
            setTitleColor(Colors.leftMenuActiveTextColor, forState: UIControlState.Normal)
        }
        else
        {
         setTitleColor(Colors.leftMenuInactiveTextColor, forState: UIControlState.Normal)
        }
        setNeedsDisplay()
    }
    }
     override init(frame: CGRect) {
        _active=false
        
        //var f:CGRect
        /*
        if frame == nil
        {
             f=CGRect()
        }
        else
        {
            f=frame!
        }
 */
        super.init(frame: frame)
        setTitleColor(Colors.leftMenuInactiveTextColor, forState: UIControlState.Normal)
        // Initialization code
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect)
    {
        super.drawRect(rect)
        Debug.print("Checkbox::drawRect \(rect)")
        let context:CGContext = UIGraphicsGetCurrentContext()!
        CGContextSetLineWidth(context,2.0)
        let c:CGColor=Colors.leftMenuBorderColor.CGColor
        CGContextSetStrokeColorSpace(context, CGColorGetColorSpace(c))
        CGContextSetStrokeColorWithColor(context, c)
        CGContextSetFillColorSpace(context, CGColorGetColorSpace(c))
        CGContextSetFillColorWithColor(context, c)
        CGContextBeginPath(context)
        if(active)
        {
            
            CGContextMoveToPoint(context,0 ,self.frame.height-2.0)
            CGContextAddLineToPoint(context,0.5*frame.width-5, frame.height-2.0)
            CGContextAddLineToPoint(context,0.5*frame.width, frame.height-7.0)
            CGContextAddLineToPoint(context,0.5*frame.width+5, frame.height-2.0)
            CGContextAddLineToPoint(context,frame.width, frame.height-2.0)
            CGContextAddLineToPoint(context,0.5*frame.width-5, frame.height-2.0)
            
        }
        else
        {
            
            CGContextMoveToPoint(context,0 ,self.frame.height-2.0)
            CGContextAddLineToPoint(context,frame.width, frame.height-2.0)
        }
        
        CGContextDrawPath(context,CGPathDrawingMode(rawValue: 3)!)
    }
    
}
