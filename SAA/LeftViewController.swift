//
//  LeftViewController.swift
//  SAA
//
//  Created by Thomas Nowak on 14.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class LeftViewController: BaseViewController , FilterDelegate {

    var calendar:LeftFilterViewController
    var keywords:LeftFilterViewController
    var canals:LeftFilterViewController
    //var forum:UIView;
    
    var pane:Int = -1;
    var filter:Filter;
    var config:ConfigFilterViewController?
    
    
    
    init(filter: Filter) {
        calendar=CalendarController(filter: filter);
        keywords=KeywordController(filter:filter)
        canals=CanalViewController(filter: filter)
        //forum=UIImageView()
        self.filter=filter;
        //forum.setTranslatesAutoresizingMaskIntoConstraints(false)
        super.init(nibName: nil, bundle: nil)
        // Custom initialization
            }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        Debug.print("BaseViewController::TranslatesAutoresizingMaskIntoConstraints \(view.translatesAutoresizingMaskIntoConstraints())")
        super.viewDidLoad()
        addChild(calendar)
        //calendar.view.backgroundColor=UIColor.brownColor()
        calendar.delegate=self
        
        addChild(keywords)
        keywords.delegate=self
        
        addChild(canals)
        canals.delegate=self
      // view.addSubview(forum)

        setConstraints()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        calendar.view.backgroundColor=UIColor.redColor()
    
    }
    
    var configConstraints = []
    func  showConfig(pane: Int)
    {
        Debug.print("\(self.description)::showConfig")
        config=ConfigFilterViewController(pane: pane, filter: filter)
        config!.delegate = self
       //presentViewController(config, animated: false,nil)
        addChild(config)
        configConstraints = [
            NSLayoutConstraint(item: config?.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: config?.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: config?.view,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: config?.view,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 0),
        ]
     view.addConstraints(configConstraints)
    }
    
    func showFilter()
    {
        view.removeConstraints(configConstraints)
        removeChild(config!)
        
        calendar.updateDisplay()
        canals.updateDisplay()
        keywords.updateDisplay()
    }
    
    func setConstraints(){
        Debug.print("\(self.description)::setConstraints")
        var constraints = [
            NSLayoutConstraint(item: calendar.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 10),
            NSLayoutConstraint(item: calendar.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: calendar.view,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: calendar.view,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 50),
            
            NSLayoutConstraint(item: canals.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: calendar.view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 15),
            NSLayoutConstraint(item: canals.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: canals.view,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: canals.view,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1.0,constant: 70),
            
          
            NSLayoutConstraint(item: keywords.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: canals.view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 15),
            NSLayoutConstraint(item: keywords.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: keywords.view,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: keywords.view,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Height,multiplier: 0.3,constant: 0),
            
            /*
            NSLayoutConstraint(item: forum,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: keywords.view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 15),
            NSLayoutConstraint(item: forum,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: forum,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: forum,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant:0 )
            */
        ]
        view.addConstraints(constraints)
    }

    override func didReceiveMemoryWarning() {
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
