//
//  DonatView.swift
//  SAA
//
//  Created by Thomas Nowak on 24.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class DonatView: UIView {

    var positive:Int64=0
    var negative:Int64=0
    var neutral:Int64=0
    
    
    init(pos:Int64, neg:Int64 , neutr:Int64) {
        
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setTranslatesAutoresizingMaskIntoConstraints(false)
        refresh(pos,neg: neg,neutr: neutr)
        backgroundColor=Colors.transparent
        // Initialization code
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func refresh(pos:Int64, neg:Int64 , neutr:Int64)
    {
        positive=pos
        negative=neg
        neutral=neutr
        setNeedsDisplay()
    }
    
    func polar2cart(angle:Double,radius:Double) -> CGPoint
    {
        var point=CGPoint()
        point.x=CGFloat(radius * cos(M_2_PI+angle))
        point.y=CGFloat(radius * sin(M_2_PI+angle))
        
        return point
    }
    
    func anz2rad(anz:Int64,max:Int64) -> Double
    {
        var result:Double=0.0
        if(max != 0)
        {
            result=2*M_PI*Double(anz)/Double(max)
        }
        return result
    }
    
    func getMin(rect:CGRect) -> CGFloat
    {
        var min=rect.width
        if(rect.height < min)
        {
            min=rect.height
        }
        return min
    }
    
    override func drawRect(rect: CGRect)
    {
        super.drawRect(rect)
        let maxRadius=getMin(rect)/2
    
        let borderRadius=maxRadius - 5
        let outerRadius=borderRadius - 5
        let innerRadius=outerRadius - 20
        
        let max:Int64=positive+negative+neutral
        let posrad=anz2rad(positive,max: max)
        let negrad=anz2rad(negative,max: max)
        let neurad=anz2rad(neutral,max: max)
        
        Debug.print("DonatView::drawRect max=\(max) posrad=\(posrad) negrad=\(negrad) neurad=\(neurad) borderRadius=\(borderRadius)  outerRadius=\(outerRadius)  innerRadius=\(innerRadius)")
        
        let centerPoint=CGPoint(x: frame.width/2.0, y: frame.height/2.0)
        let startPoint=(x: CGFloat(centerPoint.x + CGFloat(innerRadius + ( outerRadius - innerRadius ) / 2.0)), y: centerPoint.y)
        let context:CGContext = UIGraphicsGetCurrentContext()
        let linewidth=outerRadius-innerRadius
        let radius=innerRadius+linewidth/2.0
        
        CGContextSetLineWidth(context,CGFloat(linewidth))
        var c:CGColor=Colors.transparent.CGColor
        if(positive > 0)
        {
        c=Colors.sentimentPositiveGrafikColor.CGColor
        CGContextSetStrokeColorSpace(context, CGColorGetColorSpace(c))
        CGContextSetStrokeColorWithColor(context, c)
        CGContextSetFillColorSpace(context, CGColorGetColorSpace(c))
        CGContextSetFillColorWithColor(context, c)
        
        
        CGContextBeginPath(context)
        CGContextAddArc(context, centerPoint.x, centerPoint.y, CGFloat(radius), 0, CGFloat(posrad), 0)
        CGContextDrawPath(context,CGPathDrawingMode(2))
        }
        if(negative > 0 )
        {
        c=Colors.sentimentNegativeGrafikColor.CGColor
        CGContextSetStrokeColorSpace(context, CGColorGetColorSpace(c))
        CGContextSetStrokeColorWithColor(context, c)
        CGContextSetFillColorSpace(context, CGColorGetColorSpace(c))
        CGContextSetFillColorWithColor(context, c)
        
        
        CGContextBeginPath(context)
        CGContextAddArc(context, centerPoint.x, centerPoint.y, CGFloat(radius), CGFloat(posrad), CGFloat(posrad+negrad), 0)
        CGContextDrawPath(context,CGPathDrawingMode(2))
        }
        
        if(neutral > 0)
        {
        c=Colors.sentimentNeutralGrafikColor.CGColor
        CGContextSetStrokeColorSpace(context, CGColorGetColorSpace(c))
        CGContextSetStrokeColorWithColor(context, c)
        CGContextSetFillColorSpace(context, CGColorGetColorSpace(c))
        CGContextSetFillColorWithColor(context, c)
        
        
        CGContextBeginPath(context)
        CGContextAddArc(context, centerPoint.x, centerPoint.y, CGFloat(radius), CGFloat(posrad+negrad), CGFloat(posrad+negrad+neurad), 0)
        CGContextDrawPath(context,CGPathDrawingMode(2))
        }
        
        c=Colors.sentimentBorderColor.CGColor
        CGContextSetLineWidth(context,CGFloat(2))
        CGContextSetStrokeColorSpace(context, CGColorGetColorSpace(c))
        CGContextSetStrokeColorWithColor(context, c)
        CGContextSetFillColorSpace(context, CGColorGetColorSpace(c))
        CGContextSetFillColorWithColor(context, c)
        let dashLengths = [CGFloat(2.0), CGFloat(2.0)];
        CGContextSetLineDash(context, CGFloat(0.2), dashLengths, 1)
        
        
        CGContextBeginPath(context)
        CGContextAddArc(context, centerPoint.x, centerPoint.y, CGFloat(borderRadius), CGFloat(0), CGFloat(2 * M_PI), 0)
        CGContextDrawPath(context,CGPathDrawingMode(2))
            /*
            var arc = CGPathCreateMutable();
            CGPathMoveToPoint(arc, nil,startPoint.x, startPoint.y);
            CGPathAddArc(arc, nil,centerPoint.x, centerPoint.y,innerRadius+(outerRadius-innerRadius/2.0),0,posrad,1);
            CGContextAddPath(context,arc)
            CGContextDrawPath(context,CGPathDrawingMode(1))
        */
        
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
