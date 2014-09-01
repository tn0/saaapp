//
//  CalendarController.swift
//  SAA
//
//  Created by Thomas Nowak on 8.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//
/*
Anzeige der Filtereinstellung für Start und Enddatum
*/
import UIKit
import Foundation

class CalendarController: LeftFilterViewController {
    var zeitraum:UILabel
    var filter:Filter;
    var formatter:NSDateFormatter
   
    init(filter:Filter) {
        self.filter=filter
        zeitraum=UILabel()
        zeitraum.setTranslatesAutoresizingMaskIntoConstraints(false)
        zeitraum.textColor=Colors.zeitraumLabelTextColor
        zeitraum.font=UIFont.systemFontOfSize(UIFont.systemFontSize())
        formatter=NSDateFormatter()
        formatter.dateFormat="dd.MMMM.yyyy"
        
        
        super.init(nibName: nil,bundle: nil)
        button.text="< Zeitraum"
        pane = 0
        // Initialization code here.
        updateDisplay()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func updateDisplay()
    {
        super.updateDisplay()
        if(filter.zeitraum.useFilter)
        {
            Debug.print("Filter Zeitraum begin \(filter.zeitraum.begin)  end \(filter.zeitraum.end) + formatter "+formatter.stringFromDate(filter.zeitraum.end))
            zeitraum.text=formatter.stringFromDate(filter.zeitraum.begin) + " - " + formatter.stringFromDate(filter.zeitraum.end)
            zeitraum.setTranslatesAutoresizingMaskIntoConstraints(false);
            
        }
        else
        {
            zeitraum.text="Gesamter Zeitraum"
        }
    }
    override func viewDidLoad() {
        Debug.print("CalendarController::viewDidLoad")
        super.viewDidLoad()
        
        
        Debug.print("CalendarController::viewDidLoad: add zeitraum to content")
        content.addSubview(zeitraum)
        
        Debug.print("Constrains from super \(view)")
        setConstraints()
        
    }
    override func viewDidLayoutSubviews()
    {
        Debug.print("\(self.description) view \(view.frame) content \(content.frame)")
    }
    
    override func setConstraints() {
        Debug.print("setConstraints in CalendarController zeitraum \(zeitraum.debugDescription) content \(content.debugDescription)")
        
        var constraints = [
            
            NSLayoutConstraint(item: zeitraum,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: content,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: zeitraum,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: content,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
        ]
        
        content.addConstraints(constraints)
        super.setConstraints()
        
    }

    
}
