//
//  ConfigZeitraumViewController.swift
//  SAA
//
//  Created by Thomas Nowak on 17.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class ConfigZeitraumViewController: BaseConfigViewController ,CalendarDelegate, CheckboxDelegate{

    var von:UIButton;
    var bis:UIButton;
    var head:UILabel;
    var calendar:CalendarViewController
    var cur:Int=0
    
    var definedAll:CheckboxViewController
    var definedYear:CheckboxViewController
    var definedMonth:CheckboxViewController
    var definedQuartal:CheckboxViewController
    
    override init(_filter:Filter)
    {
        Debug.print("ConfigZeitraumViewController::init")
        von=UIButton()
        von.setTranslatesAutoresizingMaskIntoConstraints(false)
        von.setTitle("Von", forState: UIControlState.Normal)
        bis=UIButton()
        bis.setTranslatesAutoresizingMaskIntoConstraints(false)
        bis.setTitle("Bis", forState: UIControlState.Normal)
        head=UILabel()
        head.setTranslatesAutoresizingMaskIntoConstraints(false)
        head.text="Vordefinierte Zeiträume"
        head.textColor=Colors.configLabelTextColor
        calendar=CalendarViewController(date: _filter.zeitraum.begin)
        definedAll=CheckboxViewController(status: CheckBoxState.SELECTED)
        definedAll.text="Gesamter Zeitraum"
        definedYear=CheckboxViewController(status: CheckBoxState.UNSELECTED)
        definedYear.text="Laufendes Jahr"
        definedMonth=CheckboxViewController(status: CheckBoxState.UNSELECTED)
        definedMonth.text="Laufender Monat"
        definedQuartal=CheckboxViewController(status: CheckBoxState.UNSELECTED)
        definedQuartal.text="Laufendes Quartal"
        super.init(_filter: _filter)
        calendar.delegate=self
        cur=0
        von.addTarget(self, action: "selVon:",  forControlEvents: UIControlEvents.TouchDown)
        
        von.backgroundColor=Colors.zeitraumConfigActiveBackgroundColor;
        von.setTitleColor(Colors.zeitraumConfigActiveTitleColor, forState: UIControlState.Normal)
        bis.addTarget(self, action: "selBis:",  forControlEvents: UIControlEvents.TouchDown)
        bis.backgroundColor=Colors.zeitraumConfigInactiveBackgroundColor;
        bis.setTitleColor(Colors.zeitraumConfigInactiveTitleColor, forState: UIControlState.Normal)
        calendar.date=filter.zeitraum.begin
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refreshCalendar()
    {
        if(cur == 0)
        {
            
            calendar.date=filter.zeitraum.begin
        }
        else
        {
            
            calendar.date=filter.zeitraum.end
        }
    }
    
    func dateSelected()
    {
        //filter.zeitraum.useFilter=true
        if(filter.zeitraum.useFilter)
        {
            definedAll.status=CheckBoxState.UNSELECTED
        }
        else
        {
            definedAll.status=CheckBoxState.SELECTED
        }
        definedMonth.status=CheckBoxState.UNSELECTED
        definedQuartal.status=CheckBoxState.UNSELECTED
        definedYear.status=CheckBoxState.UNSELECTED
        if(cur == 0)
        {
            Debug.print("aktualisiere von \(calendar.date)")
            filter.zeitraum.begin=calendar.date
        }
        else
        {
            Debug.print("aktualisiere bis \(calendar.date)®")
            filter.zeitraum.end=calendar.date
        }
    }
    
    func selVon(sender: UIButton)
    {
        von.backgroundColor=Colors.zeitraumConfigActiveBackgroundColor;
        von.setTitleColor(Colors.zeitraumConfigActiveTitleColor, forState: UIControlState.Normal)
        bis.addTarget(self, action: "selBis:",  forControlEvents: UIControlEvents.TouchDown)
        bis.backgroundColor=Colors.zeitraumConfigInactiveBackgroundColor;
        bis.setTitleColor(Colors.zeitraumConfigInactiveTitleColor, forState: UIControlState.Normal)
        calendar.date=filter.zeitraum.begin
        cur=0
    }
    
    func selBis(sender: UIButton)
    {
        von.backgroundColor=Colors.zeitraumConfigInactiveBackgroundColor;
        von.setTitleColor(Colors.zeitraumConfigInactiveTitleColor, forState: UIControlState.Normal)
        
        bis.backgroundColor=Colors.zeitraumConfigActiveBackgroundColor;
        bis.setTitleColor(Colors.zeitraumConfigActiveTitleColor, forState: UIControlState.Normal)
        calendar.date=filter.zeitraum.end
        cur=1
    }
    
    override func viewDidLoad() {
        Debug.print("ConfigViewZeitraumController::viewDidLoad")
        super.viewDidLoad()
        view.addSubview(von)
        view.addSubview(bis)
        view.addSubview(head)
        addChild(calendar)
        
        addChild(definedAll)
        definedAll.delegate=self
        addChild(definedYear)
        definedYear.delegate=self
        addChild(definedMonth)
        definedMonth.delegate=self
        addChild(definedQuartal)
        definedQuartal.delegate=self
        setConstraints()
        
        
        // Do any additional setup after loading the view.
    }

    func checkboxStateChanged(sender: CheckboxViewController, state: CheckBoxState)
    {
        if(sender == definedAll)
        {
            if(state != CheckBoxState.DISABLE)
            {
              if(state == CheckBoxState.SELECTED)
              {
                definedYear.status=CheckBoxState.UNSELECTED
                definedMonth.status=CheckBoxState.UNSELECTED
                definedQuartal.status=CheckBoxState.UNSELECTED
                filter.zeitraum.begin=DateUtilities.startOfTime(NSDate())
                filter.zeitraum.end=DateUtilities.endOfTime(NSDate())
                filter.zeitraum.useFilter=false;
              }
              else
              {
                filter.zeitraum.useFilter=true;
              }
            }
           
        }
        if(sender == definedYear)
        {
            if(state != CheckBoxState.DISABLE)
            {
                filter.zeitraum.useFilter=true;
                if(state == CheckBoxState.SELECTED)
                {
                    definedAll.status=CheckBoxState.UNSELECTED
                    definedMonth.status=CheckBoxState.UNSELECTED
                    definedQuartal.status=CheckBoxState.UNSELECTED
                    filter.zeitraum.begin=DateUtilities.startOfYear(NSDate())
                    filter.zeitraum.end=DateUtilities.endOfYear(NSDate())
                }
                
            }
            
        }
        if(sender == definedMonth)
        {
            if(state != CheckBoxState.DISABLE)
            {
                filter.zeitraum.useFilter=true;
                if(state == CheckBoxState.SELECTED)
                {
                    definedAll.status=CheckBoxState.UNSELECTED
                    definedYear.status=CheckBoxState.UNSELECTED
                    definedQuartal.status=CheckBoxState.UNSELECTED
                    filter.zeitraum.begin=DateUtilities.startOfMonth(NSDate())
                    filter.zeitraum.end=DateUtilities.endOfMonth(NSDate())
                }
                
            }
        }
        if(sender == definedQuartal)
        {
            if(state != CheckBoxState.DISABLE)
            {
                filter.zeitraum.useFilter=true;
                if(state == CheckBoxState.SELECTED)
                {
                    definedAll.status=CheckBoxState.UNSELECTED
                    definedYear.status=CheckBoxState.UNSELECTED
                    definedMonth.status=CheckBoxState.UNSELECTED
                    filter.zeitraum.begin=DateUtilities.startOfQuartal(NSDate())
                    filter.zeitraum.end=DateUtilities.endOfQuartal(NSDate())
                }
                
            }
        }
        
        refreshCalendar()
        
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        Debug.print("ConfigZeitraumViewController::viewDidLayoutSubviews frame:\(view.frame)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setConstraints()
    {
        Debug.print("\(self.description)::setConstraints")
        var constraints = [
            NSLayoutConstraint(item: von,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 20),
            NSLayoutConstraint(item: von,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: von,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 0.25,constant: 0),
            NSLayoutConstraint(item: von,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 40),
            
            NSLayoutConstraint(item: bis,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 20),
            NSLayoutConstraint(item: bis,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: von,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 20),
            NSLayoutConstraint(item: bis,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 0.25,constant: 0),
            NSLayoutConstraint(item: bis,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 40),
            
            NSLayoutConstraint(item: calendar.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: von,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 20),
            NSLayoutConstraint(item: calendar.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: calendar.view,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: calendar.view,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 230),
            
            NSLayoutConstraint(item: head,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: calendar.view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 20),
            NSLayoutConstraint(item: head,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: head,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 1,constant: 0),
            //NSLayoutConstraint(item: head,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 40),
            NSLayoutConstraint(item: definedAll.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: head,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 20),
            NSLayoutConstraint(item: definedAll.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: definedAll.view,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: definedAll.view,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 40),
            
            NSLayoutConstraint(item: definedYear.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: definedAll.view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 20),
            NSLayoutConstraint(item: definedYear.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: definedYear.view,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: definedYear.view,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 40),
            
            NSLayoutConstraint(item: definedMonth.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: definedYear.view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 20),
            NSLayoutConstraint(item: definedMonth.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: definedMonth.view,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: definedMonth.view,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 40),
            
            NSLayoutConstraint(item: definedQuartal.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: definedMonth.view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 20),
            NSLayoutConstraint(item: definedQuartal.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: definedQuartal.view,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: definedQuartal.view,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 40),
            
            
            
        ]
        view.addConstraints(constraints)
    }

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
