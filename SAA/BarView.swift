//
//  BarView.swift
//  SAA
//
//  Created by Thomas Nowak on 23.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class BarView: UIView {

    
    var anz:Int64=0
    var max:Int64=0
    
    init(anz:Int64 , max:Int64) {
         var frame=CGRect(x: 0, y: 0, width: 0, height: 0)
        
        
        super.init(frame: frame)
        // Initialization code
        refresh(anz,max: max)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func refresh(anz:Int64 , max:Int64)
    {
        self.anz=anz
        self.max=max
        setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect)
    {
        super.drawRect(rect)
        if(max > 0)
        {
            var l:Double=Double(anz)/Double(max);
            var context:CGContext = UIGraphicsGetCurrentContext()
            CGContextSetLineWidth(context,1.0)
            var c:CGColor=Colors.channelGraficBarColor.CGColor
            CGContextSetStrokeColorSpace(context, CGColorGetColorSpace(c))
            CGContextSetStrokeColorWithColor(context, c)
            CGContextSetFillColorSpace(context, CGColorGetColorSpace(c))
            CGContextSetFillColorWithColor(context, c)
            CGContextBeginPath(context)
            CGContextMoveToPoint(context,0 ,0)
            
            CGContextAddLineToPoint(context,CGFloat(l)*frame.width, 0)
            CGContextAddLineToPoint(context,CGFloat(l)*frame.width, frame.height)
            CGContextAddLineToPoint(context,0, frame.height)
            CGContextDrawPath(context,CGPathDrawingMode(3))
        }
        
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
