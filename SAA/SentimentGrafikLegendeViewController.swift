//
//  SentimentGrafikLegendeViewController.swift
//  SAA
//
//  Created by Thomas Nowak on 24.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class SentimentGrafikLegendeViewController: BaseViewController {

    var positiveBox:UIView
    var positiveLabel:UILabel
    var negativeBox:UIView
    var negativeLabel:UILabel
    var neutralBox:UIView
    var neutralLabel:UILabel
    
    override init()
    {
        positiveBox=UIView()
        negativeBox=UIView()
        neutralBox=UIView()
        positiveLabel=UILabel()
        negativeLabel=UILabel()
        neutralLabel=UILabel()
        
        
        
        super.init()
        
    }
    
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        
        
        positiveLabel.text="Positiv"
        negativeLabel.text="Negativ"
        neutralLabel.text="Neutral"
        
        positiveLabel.font=UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        neutralLabel.font=UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        negativeLabel.font=UIFont.systemFontOfSize(UIFont.smallSystemFontSize())

        
        positiveLabel.textColor=Colors.leftMenuInactiveTextColor
        neutralLabel.textColor=Colors.leftMenuInactiveTextColor
        negativeLabel.textColor=Colors.leftMenuInactiveTextColor
        
        positiveLabel.textAlignment=NSTextAlignment.Right
        negativeLabel.textAlignment=NSTextAlignment.Right
        neutralLabel.textAlignment=NSTextAlignment.Right
        
        positiveBox.backgroundColor=Colors.sentimentPositiveGrafikColor
        negativeBox.backgroundColor=Colors.sentimentNegativeGrafikColor
        neutralBox.backgroundColor=Colors.sentimentNeutralGrafikColor
        
        positiveLabel.font=UIFont.systemFontOfSize(UIFont.smallSystemFontSize()*0.8)
        negativeLabel.font=UIFont.systemFontOfSize(UIFont.smallSystemFontSize()*0.8)
        neutralLabel.font=UIFont.systemFontOfSize(UIFont.smallSystemFontSize()*0.8)
        
        view.addSubview(positiveLabel)
        view.addSubview(positiveBox)
        view.addSubview(negativeLabel)
        view.addSubview(negativeBox)
        view.addSubview(neutralLabel)
        view.addSubview(neutralBox)
 
        
        super.viewDidLoad()

        positiveBox.translatesAutoresizingMaskIntoConstraints=false
        
        negativeBox.translatesAutoresizingMaskIntoConstraints=false
        neutralBox.translatesAutoresizingMaskIntoConstraints=false
        positiveLabel.translatesAutoresizingMaskIntoConstraints=false
        negativeLabel.translatesAutoresizingMaskIntoConstraints=false
        neutralLabel.translatesAutoresizingMaskIntoConstraints=false
        view.translatesAutoresizingMaskIntoConstraints=false
        
        setConstraints()
        
        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func setConstraints()
    {
        
        var constraints:[NSLayoutConstraint] = [
            
            
            NSLayoutConstraint(item: positiveLabel,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            
            NSLayoutConstraint(item:positiveLabel,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            
            NSLayoutConstraint(item:positiveLabel,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 50),
            ]
        view.addConstraints(constraints)
        constraints = [
            NSLayoutConstraint(item: positiveBox,attribute: NSLayoutAttribute.CenterY,relatedBy: NSLayoutRelation.Equal,toItem: positiveLabel,attribute: NSLayoutAttribute.CenterY,multiplier: 1,constant: 0),
            
            NSLayoutConstraint(item:positiveBox,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: positiveLabel,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 10),
            
            NSLayoutConstraint(item:positiveBox,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: positiveLabel,attribute: NSLayoutAttribute.Height,multiplier: 0.8,constant: 0),
            
            NSLayoutConstraint(item:positiveBox,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: positiveBox,attribute: NSLayoutAttribute.Height,multiplier: 1,constant: 0)
            ]
        view.addConstraints(constraints)

        
            constraints = [
            
            NSLayoutConstraint(item:negativeLabel,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: positiveLabel,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:negativeLabel,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:negativeLabel,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 50),
        ]
        view.addConstraints(constraints)
        constraints = [
            NSLayoutConstraint(item:negativeBox,attribute: NSLayoutAttribute.CenterY,relatedBy: NSLayoutRelation.Equal,toItem: negativeLabel,attribute: NSLayoutAttribute.CenterY,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:negativeBox,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: negativeLabel,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 10),
            NSLayoutConstraint(item:negativeBox,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: negativeLabel,attribute: NSLayoutAttribute.Height,multiplier: 0.8,constant: 0),
            NSLayoutConstraint(item:negativeBox,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: negativeBox,attribute: NSLayoutAttribute.Height,multiplier: 1,constant: 0)
            ]
        view.addConstraints(constraints)


            constraints = [
            NSLayoutConstraint(item:neutralLabel,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: negativeLabel,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:neutralLabel,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:neutralLabel,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 50),
        ]
        view.addConstraints(constraints)
        constraints = [
            NSLayoutConstraint(item:neutralBox,attribute: NSLayoutAttribute.CenterY,relatedBy: NSLayoutRelation.Equal,toItem: neutralLabel,attribute: NSLayoutAttribute.CenterY,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:neutralBox,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: neutralLabel,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 10),
            NSLayoutConstraint(item:neutralBox,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: neutralLabel,attribute: NSLayoutAttribute.Height,multiplier: 0.8,constant: 0),
            NSLayoutConstraint(item:neutralBox,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: neutralBox,attribute: NSLayoutAttribute.Height,multiplier: 1,constant: 0),
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
