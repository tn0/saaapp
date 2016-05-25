//
//  File.swift
//  SAA
//
//  Created by Thomas Nowak on 20.6.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//
/*
konfigbackground 3f3f41
orange: ff6821

*/
import Foundation
import UIKit

struct Colors {
    static let Color1:UIColor=Colors.rgbToUiColor(0xe0e0e0,alpha:1.0)
    static let transparent:UIColor=Colors.rgbToUiColor(0xffffff, alpha: 0)
    
    static let navBarBackgroundColor:UIColor=Color1
    static let zeitraumBackgroundColor:UIColor=transparent
    static let backgroundColor:UIColor=UIColor.whiteColor()
    static let leftBackgroundColor:UIColor=transparent
    static let topBackgroundColor:UIColor=transparent
    static let grafikBackgroundColor:UIColor=transparent
    static let FilterOKButtonBackgroundColor:UIColor=Colors.rgbToUiColor(0x5985a8, alpha: 1.0)
    static let FilterOKButtonTextColor:UIColor=UIColor.whiteColor()
    static let statusBackgroundColor:UIColor=UIColor.yellowColor()
    static let configMenuBorderColor:UIColor=UIColor.lightGrayColor()
    
    static let calendarButtonDisableBorderColor:UIColor=Colors.rgbToUiColor(0xffffff, alpha: 0)
    static let calendarButtonInactiveBorderColor:UIColor=UIColor.lightGrayColor()
    static let calendarButtonActiveBorderColor:UIColor=UIColor.whiteColor()
    
    static let calendarButtonDisableBackgroundColor:UIColor=Colors.rgbToUiColor(0xffffff, alpha: 0)
    static let calendarButtonInactiveBackgroundColor:UIColor=Colors.rgbToUiColor(0x999999, alpha: 0)
    static let calendarButtonActiveBackgroundColor:UIColor=Colors.rgbToUiColor(0xff6821, alpha: 1)
    
    static let calendarButtonDisableTintColor:UIColor=UIColor.darkGrayColor()
    static let calendarButtonInactiveTintColor:UIColor=Colors.rgbToUiColor(0xcccccc, alpha: 1)
    static let calendarButtonActiveTintColor:UIColor=UIColor.whiteColor()
    
    static let calendarMonthColor:UIColor=Colors.rgbToUiColor(0xff6821, alpha: 1)
    static let calendarYearColor:UIColor=Colors.rgbToUiColor(0xff6821, alpha: 1)
    static let configLabelTextColor:UIColor=Colors.rgbToUiColor(0xcccccc, alpha: 1)
    static let zeitraumConfigActiveBackgroundColor:UIColor=Colors.rgbToUiColor(0x3f3f41, alpha: 0)
    static let zeitraumConfigInactiveBackgroundColor:UIColor=Colors.rgbToUiColor(0x999999, alpha: 0)
    static let zeitraumConfigActiveTitleColor:UIColor=Colors.rgbToUiColor(0xffffff, alpha: 1)
    static let zeitraumConfigInactiveTitleColor:UIColor=Colors.rgbToUiColor(0x999999, alpha: 1)
    static let checkboxSelectedColor:UIColor=Colors.rgbToUiColor(0xff6821, alpha: 1)
    static let checkboxUnselectedColor:UIColor=Colors.rgbToUiColor(0xcccccc, alpha: 1)
    static let leftMenuBorderColor:UIColor=Colors.rgbToUiColor(0xcccccc, alpha: 1)
    static let leftMenuActiveTextColor:UIColor=Colors.rgbToUiColor(0xcccccc, alpha: 1)
    static let leftMenuInactiveTextColor:UIColor=Colors.rgbToUiColor(0x666666, alpha: 1)
    static let configPaneBackgroundColor:UIColor=Colors.rgbToUiColor(0x404040, alpha: 1)
    
    static let zeitraumLabelTextColor:UIColor=Colors.rgbToUiColor(0xff6821, alpha: 1)
    static let calloutButtonTextColor:UIColor=Colors.rgbToUiColor(0x666666, alpha: 1)
    static let channelGraficBarColor:UIColor=Colors.rgbToUiColor(0x5985a8, alpha: 1.0)
    
    static let sentimentPositiveGrafikColor:UIColor=Colors.rgbToUiColor(0x81ac64, alpha: 1)
    static let sentimentNegativeGrafikColor:UIColor=Colors.rgbToUiColor(0xc95756, alpha: 1)
    static let sentimentNeutralGrafikColor:UIColor=Colors.rgbToUiColor(0xe6e6e6, alpha: 1)
    static let sentimentBorderColor:UIColor=Colors.rgbToUiColor(0xcbcbcb, alpha: 1)
    
    
    static let grafikBorderColor:UIColor=Colors.rgbToUiColor(0xcbcbcb, alpha: 1)
    static let grafikIndicatorColor:UIColor=Colors.rgbToUiColor(0xd86024, alpha: 1)
    
    static let topButtonSelectedBackgroundColor:UIColor=Colors.rgbToUiColor(0x779ab8, alpha: 1)
    static let topButtonBackgroundColor:UIColor=Colors.rgbToUiColor(0x779ab8, alpha: 1)
    static let topButtonDisabeledTitleColor:UIColor=Colors.rgbToUiColor(0xffffff, alpha: 1)
    static let topButtonSelectedTitleColor:UIColor=Colors.rgbToUiColor(0xffffff, alpha: 1)
    static let topButtonTitleColor:UIColor=Colors.rgbToUiColor(0xffffff, alpha: 1)
    static let topButtonDisabeledBackgroundColor:UIColor=Colors.rgbToUiColor(0xe6e6e6, alpha: 1)
    
    static func rgbToUiColor(rgb:Int,alpha:Float) -> UIColor {
        let r = Float( rgb >> 16 & 0xFF )/255.0;
        let g = Float( rgb >> 8 & 0xFF )/255.0;
        let b = Float( rgb  & 0xFF )/255.0;
        Debug.print("red \(r) green \(g) blue \(b) alpha \(alpha)")
        let color:UIColor=UIColor(red:CGFloat(r),green:CGFloat(g),blue:CGFloat(b),alpha:CGFloat(alpha))
        return color
    }
}
