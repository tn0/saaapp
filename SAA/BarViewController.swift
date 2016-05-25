//
//  BarViewController.swift
//  SAA
//
//  Created by Thomas Nowak on 23.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class BarViewController: BaseViewController {
    
    var label:UILabel
    var anz:UILabel
    var bar:BarView
    
    init(name:String, anz: Int64, max: Int64)
    {
        Debug.print("BarViewController::init")

        label=UILabel()
        label.font=UIFont.systemFontOfSize(UIFont.smallSystemFontSize()*0.7)
        self.anz=UILabel()
        bar=BarView(anz: anz,max: max)
        bar.backgroundColor=Colors.transparent
        super.init()
        self.anz.text="\(anz)"
        self.anz.textAlignment=NSTextAlignment.Right
        self.anz.font=UIFont.systemFontOfSize(UIFont.smallSystemFontSize()*0.7)
        label.text=name
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        Debug.print("BarViewController::viewDidLoad")

        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints=false
        label.translatesAutoresizingMaskIntoConstraints=false
        
        anz.translatesAutoresizingMaskIntoConstraints=false
        bar.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(label)
        view.addSubview(anz)
        view.addSubview(bar)
        setConstraints()
        // Do any additional setup after loading the view.
    }

    func setConstraints()
    {
        Debug.print("\(self.description)::setConstraints")
        var constraints:[NSLayoutConstraint] = [
            
            
            NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 0.3,constant: 0),
            NSLayoutConstraint(item:label,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 0),
            ]
        view.addConstraints(constraints)
            
            constraints = [
            NSLayoutConstraint(item:anz,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:anz,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: label,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 5),
            NSLayoutConstraint(item:anz,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 0.2,constant: 0),
            NSLayoutConstraint(item:anz,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 0),
            ]
        view.addConstraints(constraints)
            
            constraints = [
            NSLayoutConstraint(item:bar,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:bar,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: anz,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 5),
            NSLayoutConstraint(item:bar,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:bar,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 0),
        ]
        view.addConstraints(constraints)
    }
    
    func refresh(name:String, anz:Int64,max:Int64)
    {
        Debug.print("BarViewController::refresh")

        self.anz.text="\(anz)"
        label.text=name
        bar.refresh(anz, max:max)
        
    }
    override func didReceiveMemoryWarning() {
        Debug.print("BarViewController::didReceiveMemoryWarning")

        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
