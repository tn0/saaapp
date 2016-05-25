//
//  GrafikViewController.swift
//  SAA
//
//  Created by Thomas Nowak on 21.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class GrafikViewController: BaseViewController {

    var channel:ChannelGraficViewController
    var sentiment:SentimentGraficViewController
    var keywords:KeywordTableViewController
    
    var channelIndicator:GrafikIndicator
    var sentimentIndicator:GrafikIndicator
    var keywordsIndicator:GrafikIndicator
    
    var delegate:ShowDetailsDelegate?
    
    init(filter:Filter)
    {
        
        channel=ChannelGraficViewController(filter:filter)
        sentiment=SentimentGraficViewController(filter: filter)
        keywords=KeywordTableViewController(filter:filter)
        channelIndicator=GrafikIndicator()
        sentimentIndicator=GrafikIndicator()
        keywordsIndicator=GrafikIndicator()
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints=false
        view.backgroundColor=UIColor.redColor()
        view.opaque=true;
        
        addChild(channel)
        addChild(sentiment)
        addChild(keywords)
        view.addSubview(channelIndicator)
        view.addSubview(sentimentIndicator)
        view.addSubview(keywordsIndicator)
        setConstraints()
        getData()
        
        
        
        let channelRecognizer=UITapGestureRecognizer(target: self, action: #selector(GrafikViewController.showDetails(_:)))
        channelRecognizer.numberOfTapsRequired=1;
        channelRecognizer.numberOfTouchesRequired=1;
        channel.view.addGestureRecognizer(channelRecognizer)
        let sentimentRecognizer=UITapGestureRecognizer(target: self, action:  #selector(GrafikViewController.showDetails(_:)))
        sentimentRecognizer.numberOfTapsRequired=1;
        sentimentRecognizer.numberOfTouchesRequired=1;
        sentiment.view.addGestureRecognizer(sentimentRecognizer)
        let keywordsRecognizer=UITapGestureRecognizer(target: self, action:  #selector(GrafikViewController.showDetails(_:)))
        keywordsRecognizer.numberOfTapsRequired=1;
        keywordsRecognizer.numberOfTouchesRequired=1;
        keywords.view.addGestureRecognizer(keywordsRecognizer)

// Do any additional setup after loading the view.
    }

    func showDetails(c: UITapGestureRecognizer ) {
        
        Debug.print("View touched \(c.view) channel \(channel.view) sentiment \(sentiment.view) keywords \(keywords.view)")
        var page:Int=0
        switch(c.view!)
        {
        case channel.view :
            Debug.print("Show Channels")
            page=1
            channelIndicator.selected=true
            sentimentIndicator.selected=false
            keywordsIndicator.selected=false

        case sentiment.view :
            Debug.print("Show Sentiment")
            page=2
            channelIndicator.selected=false
            sentimentIndicator.selected=true
            keywordsIndicator.selected=false
            
        case keywords.view :
            Debug.print("Show Keywords")
            page=3
            channelIndicator.selected=false
            sentimentIndicator.selected=false
            keywordsIndicator.selected=true
        default:
            page=0
            channelIndicator.selected=false
            sentimentIndicator.selected=false
            keywordsIndicator.selected=false
        }
        delegate?.showDetails(page)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var timer:NSTimer?
    func getData()
    {
            if(timer != nil)
            {
                    timer!.invalidate()
            }
        timer=NSTimer.scheduledTimerWithTimeInterval(1,target: self, selector: #selector(GrafikViewController.delayedGetData(_:)),userInfo: nil, repeats: false)
    }
    
    func delayedGetData(sender: AnyObject)
    {
        channel.getData()
        sentiment.getData()
        keywords.getData()
    }
    func setConstraints()
    {
        Debug.print("\(self.description)::setConstraints")
        var constraints:[NSLayoutConstraint] = [
            NSLayoutConstraint(item: channel.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: channel.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: channel.view,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 1.0/3.0,constant: 0),
            NSLayoutConstraint(item: channel.view,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 0),
            ]
        view.addConstraints(constraints)
        
        constraints = [
            NSLayoutConstraint(item: sentiment.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: sentiment.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: channel.view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: sentiment.view,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 1.0/3.0,constant: 0),
            NSLayoutConstraint(item: sentiment.view,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 0),
            ]
            view.addConstraints(constraints)
        
        constraints = [
            NSLayoutConstraint(item: keywords.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: keywords.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: sentiment.view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: keywords.view,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 1.0/3.0,constant: 0),
            NSLayoutConstraint(item: keywords.view,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 0),
            ]
            view.addConstraints(constraints)
        
        constraints = [
            NSLayoutConstraint(item: channelIndicator,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: -10),
            NSLayoutConstraint(item: channelIndicator,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: channel.view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: channelIndicator,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: channel.view,attribute: NSLayoutAttribute.Width,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: channelIndicator,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 0),
            ]
            view.addConstraints(constraints)
        
        constraints = [
            NSLayoutConstraint(item: sentimentIndicator,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: -10),
            NSLayoutConstraint(item: sentimentIndicator,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: sentiment.view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: sentimentIndicator,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: sentiment.view,attribute: NSLayoutAttribute.Width,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: sentimentIndicator,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 0),
            ]
            view.addConstraints(constraints)
        
        constraints = [
            NSLayoutConstraint(item: keywordsIndicator,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: -10),
            NSLayoutConstraint(item: keywordsIndicator,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: keywords.view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: keywordsIndicator,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: keywords.view,attribute: NSLayoutAttribute.Width,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: keywordsIndicator,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 0),
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
