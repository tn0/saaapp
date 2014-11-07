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
    static var Color1:UIColor=Colors.rgbToUiColor(0xe0e0e0,alpha:1.0)
    static var transparent:UIColor=Colors.rgbToUiColor(0xffffff, alpha: 0)
    
    static var navBarBackgroundColor=Color1
    static var zeitraumBackgroundColor=transparent
    static var backgroundColor=UIColor.whiteColor()
    static var leftBackgroundColor=transparent
    static var topBackgroundColor=transparent
    static var grafikBackgroundColor=transparent
    static var FilterOKButtonBackgroundColor=Colors.rgbToUiColor(0x5985a8, alpha: 1.0)
    static var FilterOKButtonTextColor=UIColor.whiteColor()
    static var statusBackgroundColor=UIColor.yellowColor()
    static var configMenuBorderColor=UIColor.lightGrayColor()
    
    static var calendarButtonDisableBorderColor=Colors.rgbToUiColor(0xffffff, alpha: 0)
    static var calendarButtonInactiveBorderColor=UIColor.lightGrayColor()
    static var calendarButtonActiveBorderColor=UIColor.whiteColor()
    
    static var calendarButtonDisableBackgroundColor=Colors.rgbToUiColor(0xffffff, alpha: 0)
    static var calendarButtonInactiveBackgroundColor=Colors.rgbToUiColor(0x999999, alpha: 0)
    static var calendarButtonActiveBackgroundColor=Colors.rgbToUiColor(0xff6821, alpha: 1)
    
    static var calendarButtonDisableTintColor=UIColor.darkGrayColor()
    static var calendarButtonInactiveTintColor=Colors.rgbToUiColor(0xcccccc, alpha: 1)
    static var calendarButtonActiveTintColor=UIColor.whiteColor()
    
    static var calendarMonthColor=Colors.rgbToUiColor(0xff6821, alpha: 1)
    static var calendarYearColor=Colors.rgbToUiColor(0xff6821, alpha: 1)
    static var configLabelTextColor=Colors.rgbToUiColor(0xcccccc, alpha: 1)
    static var zeitraumConfigActiveBackgroundColor=Colors.rgbToUiColor(0x3f3f41, alpha: 0)
    static var zeitraumConfigInactiveBackgroundColor=Colors.rgbToUiColor(0x999999, alpha: 0)
    static var zeitraumConfigActiveTitleColor=Colors.rgbToUiColor(0xffffff, alpha: 1)
    static var zeitraumConfigInactiveTitleColor=Colors.rgbToUiColor(0x999999, alpha: 1)
    static var checkboxSelectedColor=Colors.rgbToUiColor(0xff6821, alpha: 1)
    static var checkboxUnselectedColor=Colors.rgbToUiColor(0xcccccc, alpha: 1)
    static var leftMenuBorderColor=Colors.rgbToUiColor(0xcccccc, alpha: 1)
    static var leftMenuActiveTextColor=Colors.rgbToUiColor(0xcccccc, alpha: 1)
    static var leftMenuInactiveTextColor=Colors.rgbToUiColor(0x666666, alpha: 1)
    static var configPaneBackgroundColor=Colors.rgbToUiColor(0x404040, alpha: 1)
    
    static var zeitraumLabelTextColor=Colors.rgbToUiColor(0xff6821, alpha: 1)
    static var calloutButtonTextColor=Colors.rgbToUiColor(0x666666, alpha: 1)
    static var channelGraficBarColor=Colors.rgbToUiColor(0x5985a8, alpha: 1.0)
    
    static var sentimentPositiveGrafikColor=Colors.rgbToUiColor(0x81ac64, alpha: 1)
    static var sentimentNegativeGrafikColor=Colors.rgbToUiColor(0xc95756, alpha: 1)
    static var sentimentNeutralGrafikColor=Colors.rgbToUiColor(0xe6e6e6, alpha: 1)
    static var sentimentBorderColor=Colors.rgbToUiColor(0xcbcbcb, alpha: 1)
    
    
    static var grafikBorderColor=Colors.rgbToUiColor(0xcbcbcb, alpha: 1)
    static var grafikIndicatorColor=Colors.rgbToUiColor(0xd86024, alpha: 1)
    
    static var topButtonSelectedBackgroundColor=Colors.rgbToUiColor(0x779ab8, alpha: 1)
    static var topButtonBackgroundColor=Colors.rgbToUiColor(0x779ab8, alpha: 1)
    static var topButtonDisabeledTitleColor=Colors.rgbToUiColor(0xffffff, alpha: 1)
    static var topButtonSelectedTitleColor=Colors.rgbToUiColor(0xffffff, alpha: 1)
    static var topButtonTitleColor=Colors.rgbToUiColor(0xffffff, alpha: 1)
    static var topButtonDisabeledBackgroundColor=Colors.rgbToUiColor(0xe6e6e6, alpha: 1)
    
    static func rgbToUiColor(rgb:Int,alpha:Float) -> UIColor {
        let r = Float( rgb >> 16 & 0xFF )/255.0;
        let g = Float( rgb >> 8 & 0xFF )/255.0;
        let b = Float( rgb  & 0xFF )/255.0;
        Debug.print("red \(r) green \(g) blue \(b) alpha \(alpha)")
        let color:UIColor=UIColor(red:CGFloat(r),green:CGFloat(g),blue:CGFloat(b),alpha:CGFloat(alpha))
        return color
    }
}
