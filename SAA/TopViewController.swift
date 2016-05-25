//
//  TopViewController.swift
//  SAA
//
//  Created by Thomas Nowak on 14.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class TopViewController: BaseViewController {
   

    var filter:Filter
    var sentiment:SentimentViewController
    var overviewButton:TopButton
    var messageButton:TopButton
    var delegate:ShowDetailsDelegate?
    
    init(filter:Filter)
    {
        Debug.print("TopView::init")
        self.filter=filter
        overviewButton=TopButton()
        messageButton=TopButton()
        sentiment=SentimentViewController(filter:filter)
        super.init()
        view.translatesAutoresizingMaskIntoConstraints=false
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        Debug.print("TopView::viewDidLoad")
        super.viewDidLoad()
        view.backgroundColor=UIColor.redColor()
        view.addSubview(overviewButton)
        view.addSubview(messageButton)
        overviewButton.setTitle("Übersicht", forState: UIControlState.Normal)
        overviewButton.translatesAutoresizingMaskIntoConstraints=false
        overviewButton.enabled=false
        overviewButton.addTarget(self, action: #selector(TopViewController.showOverview(_:)) , forControlEvents: UIControlEvents.TouchUpInside)
        
        messageButton.setTitle("Beiträge einblenden", forState: UIControlState.Normal)
        messageButton.enabled=false
        messageButton.translatesAutoresizingMaskIntoConstraints=false
        addChildViewController(sentiment)
        view.addSubview(sentiment.view)
        sentiment.didMoveToParentViewController(self)
        setConstraints()
        // Do any additional setup after loading the view.
    }

    
    func showOverview(sender:UIButton!)
    {
        Debug.print("TopView::showOverview")
        overviewButton.enabled=false;
        delegate?.showDetails(0)
        
    }
    
    override func viewDidLayoutSubviews()
    {
        Debug.print("TopView::viewDidLayoutSubviews")
        super.viewDidLayoutSubviews()
        Debug.print(" \(self.description) ---> View \(view.frame)   sentiment \(sentiment.view.frame)")
    }
    
    func setConstraints()
    {
        Debug.print("\(self.description)::setConstraints")
        var constraints:[NSLayoutConstraint] = [
            
            
            NSLayoutConstraint(item:sentiment.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:sentiment.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:sentiment.view,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 0.5,constant: 0),
           // NSLayoutConstraint(item:sentiment.view,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:sentiment.view,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 35),
            ]
        view.addConstraints(constraints)
        constraints = [
            
            NSLayoutConstraint(item:overviewButton,attribute: NSLayoutAttribute.CenterY,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.CenterY,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:overviewButton,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: messageButton,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: -10),
        ]
        view.addConstraints(constraints)
        constraints = [
            NSLayoutConstraint(item:messageButton,attribute: NSLayoutAttribute.CenterY,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.CenterY,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:messageButton,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 0),
            
        ]
        view.addConstraints(constraints)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        Debug.print("TopView::didReceiveMemoryWarnings")
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
