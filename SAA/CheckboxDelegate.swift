//
//  CheckboxDelegate.swift
//  SAA
//
//  Created by Thomas Nowak on 21.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import Foundation
protocol CheckboxDelegate {
    func checkboxStateChanged(sender: CheckboxViewController,state:CheckBoxState)
    
}