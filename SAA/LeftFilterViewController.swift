//
//  LeftFilterViewController.swift
//  SAA
//
//  Created by Thomas Nowak on 14.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit




class LeftFilterViewController: BaseViewController {
    var button:CalloutButton
    var content:UIView;
    var pane:Int = -1
    var delegate: FilterDelegate?;
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        button=CalloutButton(nibName:nil,bundle:nil);
        
        content=UIView();
        
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      
    
  
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func colorTap(c: UITapGestureRecognizer ) {
        
        Debug.print("View touched")
        
        delegate?.showConfig(pane)
        
    }
    
    func updateDisplay()
    {
        
    }
    
    override func viewDidLoad() {
        Debug.print("KeywordsController::viewDidLoad")
        super.viewDidLoad()
        content.setTranslatesAutoresizingMaskIntoConstraints(false);
        view.setTranslatesAutoresizingMaskIntoConstraints(false);
        Debug.print("LeftFilterViewController::viewDidLoad::add Content to view \(view.debugDescription)")
        addChild(button)
        view.addSubview(content);
        
        var tapRecognizer=UITapGestureRecognizer(target: self, action: "colorTap:")
        tapRecognizer.numberOfTapsRequired=1;
        tapRecognizer.numberOfTouchesRequired=1;
        view.addGestureRecognizer(tapRecognizer)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setConstraints() {
        Debug.print("setConstraints in LeftFilterController")
        var constraints = [
            NSLayoutConstraint(item: button.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: button.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: button.view,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 0),
        
            NSLayoutConstraint(item: content,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: button.view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: content,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 20),
            NSLayoutConstraint(item: content,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 0),
          //  NSLayoutConstraint(item: content,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 0),
            
            
        ]
        view.addConstraints(constraints)
        //NSLayoutConstraint.activateConstraints(constraints)
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
