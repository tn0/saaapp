//
//  CalendarViewController.swift
//  SAA
//
//  Created by Thomas Nowak on 17.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//
/*
Anzeige des Kalenders mit Möglichkeit der Auswahl eines Datum

benutzt in ConfigZeitraumViewController

*/
import UIKit
import Foundation

class CalendarViewController: BaseViewController {

    var delegate: CalendarDelegate?;
    
    var back:UIButton
    var next:UIButton
   
    var month:UILabel
    var year:UILabel
    let btn:[[CalendarButton]] = [
        [
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
        ],
        [
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
        ],
        [
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
        ],
        [
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
        ],
        [
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
        ],
        [
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
            CalendarButton(),
        ],
        
    ]
    
    var _date:NSDate;
    var _calendar:NSCalendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    var _month:Int
    var _year:Int
    var _day:Int
    
    var _oldMonth = -1
    var _oldYear = -1
    var _actbtn:CalendarButton?
    var date:NSDate {
    get {
        return _date
    }
    set {
        _date=newValue
        month.text=monthFormatter.stringFromDate(_date);
        month.textColor=Colors.calendarMonthColor
        
        year.text=yearFormatter.stringFromDate(_date);
        year.textColor=Colors.calendarYearColor
        let unitFlags:NSCalendarUnit=[.Weekday, .Year, .Month, .Day]
        let dateComponents:NSDateComponents=_calendar.components(unitFlags, fromDate: _date)
        
        _year=dateComponents.year
        _month=dateComponents.month
        _day=dateComponents.day
        Debug.print("CalendarViewController::date \(_date), day \(_day) month \(_month) year \(_year)" )
        
        if(_oldYear == _year && _oldMonth == _month)
        {
            updateCalendar()
        }
        else
        {
            refreshCalendar()
        }
        
        _oldYear=_year
        _oldMonth=_month
        
    }
    }
    
    var monthFormatter:NSDateFormatter
    var yearFormatter:NSDateFormatter
    init(date:NSDate)
    {
        Debug.print("CalendarViewController::init")
        monthFormatter=NSDateFormatter()
        monthFormatter.locale=NSLocale.currentLocale()
        monthFormatter.dateFormat="MMMM"
        yearFormatter=NSDateFormatter()
      //  yearFormatter.locale=NSLocale.currentLocale()
        yearFormatter.dateFormat="yyyy"
        
        _calendar=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        back=UIButton()
        back.setTitle("<", forState: UIControlState.Normal)
        back.translatesAutoresizingMaskIntoConstraints=false
        
        
        next=UIButton()
        next.setTitle(">", forState: UIControlState.Normal)
        next.translatesAutoresizingMaskIntoConstraints=false
       
        year=UILabel()
        year.translatesAutoresizingMaskIntoConstraints=false
        year.textAlignment=NSTextAlignment.Center
        
        
        month=UILabel()
        month.textAlignment=NSTextAlignment.Center
        month.translatesAutoresizingMaskIntoConstraints=false
        _date=date
       
        _day=1
        _month=1
        _year=1
        month.text=monthFormatter.stringFromDate(_date);
        year.text=yearFormatter.stringFromDate(_date);
        
        super.init()
        self.date=date
        view.translatesAutoresizingMaskIntoConstraints=false
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        Debug.print("CalendarViewController::viewDidLoad")
        super.viewDidLoad()
        back.addTarget(self, action: #selector(CalendarViewController.prevMonth(_:)),  forControlEvents: UIControlEvents.TouchDown)
         next.addTarget(self, action: #selector(CalendarViewController.nextMonth(_:)),  forControlEvents: UIControlEvents.TouchDown)
        
        view.addSubview(back)
        view.addSubview(next)
        view.addSubview(month)
        view.addSubview(year)
        
        month.text=monthFormatter.stringFromDate(_date)
        
        let unitFlags:NSCalendarUnit=[.Day]
        let range:NSRange=_calendar.rangeOfUnit( unitFlags, inUnit: NSCalendarUnit.Month, forDate: _date)
        
      //  let start:Int=4
      //  let day:Int=1
        Debug.print("Date \(_date) calendar \(_calendar.debugDescription)  Range \(range)")
        for i in 0...5
        {
            for j in 0...6
            {
                let curbtn:CalendarButton=btn[i][j]
                curbtn.translatesAutoresizingMaskIntoConstraints=false
                curbtn.addTarget(self, action: #selector(CalendarViewController.selDate(_:)),  forControlEvents: UIControlEvents.TouchDown)
                view.addSubview(curbtn)
                curbtn.setTitle("",forState: UIControlState.Normal)
                curbtn.enable=false
            }
        }
        setConstraints()
        refreshCalendar()
    }

    func refreshCalendar()
    {
     
        Debug.print("CalendarViewController::refreshCalendar")
            month.text = monthFormatter.stringFromDate(_date)
            year.text = yearFormatter.stringFromDate(_date)
            let unitFlags:NSCalendarUnit=[.Day]
            let range:NSRange=_calendar.rangeOfUnit( unitFlags, inUnit: NSCalendarUnit.Month, forDate: _date)
        let monthStart:NSDate = DateUtilities.startOfMonth(_date)
        let start:Int = DateUtilities.dayOfWeek(monthStart)-1
        
            var day=1
            for  i  in 0...5
            {
                for  j in 0...6
                {
                    let curbtn:CalendarButton=btn[i][j]
                    if( i == 0 && j < start )
                    {
                        curbtn.setTitle("",forState: UIControlState.Normal)
                        curbtn.enable=false
                    }
                    else
                    {
                        
                        if(day > range.length)
                        {
                            curbtn.setTitle("",forState: UIControlState.Normal)
                            curbtn.enable=false
                        }
                        else
                        {
                            curbtn.enable=true
                            curbtn.setTitle("\(day)",forState: UIControlState.Normal)
                            curbtn.day=day
                            if(_day == day )
                            {
                                curbtn.active=true;
                                _actbtn=curbtn;
                            }
                            else
                            {
                                curbtn.active=false;
                            }
                            day+=1;
                        }
                    }
                }
            }
        }
    
    func updateCalendar()
    {
        
        Debug.print("CalendarViewController::updateCalendar")
        //let unitFlags:NSCalendarUnit=[.DayCalendarUnit]
        //let range:NSRange=_calendar.rangeOfUnit( unitFlags, inUnit: NSCalendarUnit.Month, forDate: _date)
        let monthStart:NSDate=DateUtilities.startOfMonth(_date)
        let start:Int=DateUtilities.dayOfWeek(monthStart)
        _actbtn!.active=false
        let xd=_day+start - 2
        let j:Int = xd % 7
        let i:Int = xd / 7
        let curbtn:CalendarButton=btn[i][j]
        curbtn.active=true;
        _actbtn=curbtn
    }
    
    func setAllInactive()
    {
        Debug.print("CalendarViewController::setAllInactive")
        for i in 0...5
        {
            for j in 0...6
            {
                let curbtn:CalendarButton=btn[i][j]
                curbtn.active=false
            }
        }
    }
    
    func selDate(sender: CalendarButton)
    {
        Debug.print("CalendarViewController::selDate")
        if(sender.enable)
        {
            date=DateUtilities.dayOfMonth(date,day: sender.day)
            delegate?.dateSelected()
        }
    }
    
    func prevMonth(sender: UIButton)
    {
        Debug.print("CalendarViewController::prevMonth")
        date=DateUtilities.oneMonthBack(date)
        delegate?.dateSelected()
    }
    func nextMonth(sender: UIButton)
    {
        Debug.print("CalendarViewController::nextMonth")
        date=DateUtilities.oneMonthFor(date)
        delegate?.dateSelected()
        
    }
    override func didReceiveMemoryWarning() {
        Debug.print("CalendarViewController::didReceiveMemoryWarning")
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func setConstraints()
    {
        Debug.print("\(self.description)::setConstraints")
        var constraints:[NSLayoutConstraint] = [
            NSLayoutConstraint(item: back,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: back,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: back,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 1.0/6.0,constant: 0),
            NSLayoutConstraint(item: back,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 40),
            ]
        view.addConstraints(constraints)
        
            constraints = [
            NSLayoutConstraint(item: month,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: month,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: back,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: month,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 2.0/3.0,constant: 0),
            NSLayoutConstraint(item: month,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 20),
        ]
        view.addConstraints(constraints)
            constraints = [
            NSLayoutConstraint(item: year,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: month,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: year,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: back,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: year,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 2.0/3.0,constant: 0),
            NSLayoutConstraint(item: year,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 20),
        ]
        view.addConstraints(constraints)
               constraints = [
            NSLayoutConstraint(item: next,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: next,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: month,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: next,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 1.0/6.0,constant: 0),
            NSLayoutConstraint(item: next,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 40),
        ]
        view.addConstraints(constraints)
        
        var const1:NSLayoutConstraint;
        var const2:NSLayoutConstraint;
        var const3:NSLayoutConstraint;
        var const4:NSLayoutConstraint;

        for  i in 0...5
        {
            for  j
                in 0...6
            {
                let curbtn:CalendarButton=btn[i][j]
                if( i == 0 )
                {
                    const1=NSLayoutConstraint(item: curbtn,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: next,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 15)
                }
                else
                {
                    let upperbtn=btn[i-1][j]
                    const1=NSLayoutConstraint(item: curbtn,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: upperbtn,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 10)
                }
                if( j == 0 )
                {
                    const2=NSLayoutConstraint(item: curbtn,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0)
                }
                else
                {
                    let prevbtn:CalendarButton=btn[i][j-1]
                    const2=NSLayoutConstraint(item: curbtn,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: prevbtn,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 10)
                }
                const3=NSLayoutConstraint(item: curbtn,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 1.0/7.0,constant: -60.0/7.0)
                const4=NSLayoutConstraint(item: curbtn,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: curbtn,attribute: NSLayoutAttribute.Width,multiplier: 1,constant: 0)
                let c:[NSLayoutConstraint]=[
                    const1,
                    const2,
                    const3,
                    const4
                ]
                view.addConstraints(c)

            }
        }
  
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
