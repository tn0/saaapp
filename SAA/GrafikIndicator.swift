//
//  GrafikIndicator.swift
//  SAA
//
//  Created by Thomas Nowak on 2.9.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import Foundation
import UIKit

class GrafikIndicator: UIView {
    
    
    var _selected:Bool=false
    var selected:Bool {
        get {
            return _selected
        }
        set {
            _selected=newValue
            setNeedsDisplay()
        }
    }
    
    
    override init() {
        var frame=CGRect(x: 0, y: 0, width: 0, height: 0)
        
        
        super.init(frame: frame)
        setTranslatesAutoresizingMaskIntoConstraints(false)
        backgroundColor=Colors.transparent
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func drawRect(rect: CGRect)
    {
        Debug.print("selected = \(selected)")
        super.drawRect(rect)
        var width=rect.height/3
        Debug.print("selected = \(selected) rect \(rect) width \(width)")
        var context:CGContext = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context,1)
        var c:CGColor=Colors.grafikIndicatorColor.CGColor
        CGContextSetStrokeColorSpace(context, CGColorGetColorSpace(c))
        CGContextSetStrokeColorWithColor(context, c)
        CGContextSetFillColorSpace(context, CGColorGetColorSpace(c))
        CGContextSetFillColorWithColor(context, c)
        CGContextBeginPath(context)
        if(selected)
        {
        
            CGContextMoveToPoint(context,0 ,self.frame.height-width)
            CGContextAddLineToPoint(context,0.5*frame.width-frame.height, frame.height-width)
            CGContextAddLineToPoint(context,0.5*frame.width, 0)
            CGContextAddLineToPoint(context,0.5*frame.width+frame.height, frame.height-width)
            CGContextAddLineToPoint(context,frame.width, frame.height-width)
            CGContextAddLineToPoint(context,frame.width, frame.height)
            CGContextAddLineToPoint(context,0 ,self.frame.height)
            CGContextAddLineToPoint(context,0 ,self.frame.height-width)
            
        }
        else
        {
            
            CGContextMoveToPoint(context,0 ,self.frame.height-width)
            CGContextAddLineToPoint(context,frame.width, frame.height-width)
            CGContextAddLineToPoint(context,frame.width, frame.height)
            CGContextAddLineToPoint(context,0 ,self.frame.height)
            CGContextAddLineToPoint(context,0 ,self.frame.height-width)
        }
        
        CGContextClosePath(context)
        CGContextDrawPath(context,CGPathDrawingMode(3))
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
