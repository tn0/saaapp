//
//  Checkbox.swift
//  SAA
//
//  Created by Thomas Nowak on 21.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit
import CoreGraphics

class Checkbox: UIButton {
    var _status:CheckBoxState
    var status:CheckBoxState {
    get {
        return _status
    }
    set {
        _status=newValue
        if(_status == CheckBoxState.SELECTED)
        {
            layer.borderColor=Colors.checkboxSelectedColor.CGColor
        }
        else
        {
            layer.borderColor=Colors.checkboxUnselectedColor.CGColor
        }
       setNeedsDisplay()
    }
    }
    
    
    init(status:CheckBoxState) {
        let frame=CGRect(x: 0, y: 0, width: 0, height: 0)
        self._status=status
        super.init(frame: frame)
        self.setTitle("", forState: UIControlState.Normal)
        self.translatesAutoresizingMaskIntoConstraints=false
        layer.cornerRadius=15
        layer.borderWidth=2
        if(_status == CheckBoxState.SELECTED)
        {
            layer.borderColor=Colors.checkboxSelectedColor.CGColor
        }
        else
        {
        layer.borderColor=Colors.checkboxUnselectedColor.CGColor
        }
        
        
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
        if(status == CheckBoxState.SELECTED)
        {
        CGContextSetLineWidth(context,2.0)
            let c:CGColor=Colors.checkboxSelectedColor.CGColor
            CGContextSetStrokeColorSpace(context, CGColorGetColorSpace(c))
            CGContextSetStrokeColorWithColor(context, Colors.checkboxSelectedColor.CGColor)
        CGContextBeginPath(context)
        CGContextMoveToPoint(context,1.0/3.0*frame.width ,self.frame.height*0.55)
        CGContextAddLineToPoint(context,1.0/2.0*frame.width, 0.75*frame.height)
        CGContextAddLineToPoint(context,2.0/3.0*frame.width, 1.0/3.0*frame.height)
            CGContextDrawPath(context,CGPathDrawingMode(rawValue: 2)!)
        }
    }


}
