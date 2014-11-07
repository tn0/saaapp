//
//  CalloutButtom.swift
//  SAA
//
//  Created by Thomas Nowak on 23.6.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit
import Foundation

class CalloutButton: BaseViewController {

    //var image:UIImageView;
    var label:UILabel;
    var text:String {
        set(value) {
            label.text=value
        }
        get {
            return label.text!
        }
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        //image=UIImageView()
        label=UILabel()
        
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Initialization code here.
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func  viewDidLoad(){
        view.userInteractionEnabled=true
      //  image.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.textColor=Colors.calloutButtonTextColor
        /*
        var tapRecognizer=UITapGestureRecognizer(target: self, action: "colorTap:")
        tapRecognizer.numberOfTapsRequired=1;
        tapRecognizer.numberOfTouchesRequired=1;
        view.addGestureRecognizer(tapRecognizer)
*/
//view.addSubview(image)
        view.addSubview(label)
        setConstraints()
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        Debug.print("\(self.description)  view \(view.frame)")
        
    }
  /*
    func colorTap(tapGestureRecognizer: UITapGestureRecognizer ) {
        
        Debug.print("View touched")
        
    }
    */
    func setConstraints()
    {
        Debug.print("setConstraints in CalloutButton")
        var constraints = [
            /*
            NSLayoutConstraint(item: image,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: image,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
*/
//NSLayoutConstraint(item: image,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 0,constant: 0),
            
            NSLayoutConstraint(item: label,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: label,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 20),
            NSLayoutConstraint(item: view,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 25),
            //NSLayoutConstraint(item: from,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 0,constant: 0),
            
        ]
        view.addConstraints(constraints)
    }
    

}
