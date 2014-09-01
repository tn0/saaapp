//
//  Checkbox.swift
//  SAA
//
//  Created by Thomas Nowak on 21.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit
import CoreGraphics

class Roundbutton: UIButton {
    
    
    
    override init() {
        let frame=CGRect(x: 0, y: 0, width: 0, height: 0)
       
        super.init(frame: frame)
        self.setTitle("", forState: UIControlState.Normal)
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        layer.cornerRadius=15
        layer.borderWidth=2
        layer.borderColor=Colors.checkboxSelectedColor.CGColor
        
        
        // Initialization code
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
