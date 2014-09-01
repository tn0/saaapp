//
//  SAAMainControllerViewController.swift
//  SAA
//
//  Created by Thomas Nowak on 20.6.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit
import Foundation

class SAAMainController: UINavigationController,FilterChangedDelegate{

    var filter:Filter
    var left:LeftViewController;
    var top:TopViewController;
    var grafik:GrafikViewController;
    var bottom:UIViewController;
    var backgroundImage:UIImageView
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        filter=Filter()
        
        left=LeftViewController(filter: filter);
        top=TopViewController(filter:filter);
        
        grafik=GrafikViewController(filter:filter)
        bottom=BottomViewController()
        backgroundImage=UIImageView()
        backgroundImage.setTranslatesAutoresizingMaskIntoConstraints(false)
        backgroundImage.setTranslatesAutoresizingMaskIntoConstraints(false)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
      UIBarButtonItem.appearance().tintColor=Colors.navBarBackgroundColor;
        Debug.print("SAAMainControler::init")
        filter.delegate=self
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func filterChanged()
    {
        grafik.getData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        Debug.print("MainController \(view.translatesAutoresizingMaskIntoConstraints()) \(view.frame)")
        backgroundImage.image=UIImage(named: "background.png");
        view.addSubview(backgroundImage)
        view.backgroundColor=Colors.backgroundColor
      
        addChildViewController(left)
        view.addSubview(left.view)
        left.didMoveToParentViewController(self)
        left.view.backgroundColor=Colors.leftBackgroundColor
        
      
        
        addChildViewController(top)
        view.addSubview(top.view)
        top.didMoveToParentViewController(self)
        top.view.backgroundColor=Colors.topBackgroundColor
        addChildViewController(grafik)
        view.addSubview(grafik.view)
        grafik.didMoveToParentViewController(self)
        grafik.view.backgroundColor=Colors.grafikBackgroundColor
        /*
        
        addChildViewController(bottom)
        view.addSubview(bottom.view)
        bottom.didMoveToParentViewController(self)
        bottom.view.backgroundColor=Colors.bottomBackgroundColor
        */
        
        setConstraints()
  
        
        
        
        
        
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setConstraints() {
        Debug.print("\(self.description)::setConstraints")
        var constraints = [
            NSLayoutConstraint(item:backgroundImage,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: backgroundImage,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: backgroundImage,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: backgroundImage,attribute: NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Height,multiplier: 1,constant:0),
           
            NSLayoutConstraint(item: left.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 60),
            NSLayoutConstraint(item: left.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: left.view,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Width,multiplier: 0.25,constant: 0),
            NSLayoutConstraint(item: left.view,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant:0),
           
            
            
            NSLayoutConstraint(item: top.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 65),
            NSLayoutConstraint(item: top.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: left.view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 15),
            NSLayoutConstraint(item: top.view,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: -15),
            NSLayoutConstraint(item: top.view,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant:100 ),
            
            NSLayoutConstraint(item: grafik.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: top.view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 15),
           // NSLayoutConstraint(item: grafik.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: left.view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 15),
             NSLayoutConstraint(item: grafik.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 0.25,constant: 17),
            NSLayoutConstraint(item: grafik.view,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: -15),
            NSLayoutConstraint(item: grafik.view,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant:300 ),
            
            
          /*
            NSLayoutConstraint(item: bottom.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: top.view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: 15),
            NSLayoutConstraint(item: bottom.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: left.view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 15),
            NSLayoutConstraint(item: bottom.view,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: -15),
            NSLayoutConstraint(item: bottom.view,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant:0 )
            */
        ]
        view.addConstraints(constraints)
        //NSLayoutConstraint.activateConstraints(constraints)
    }

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
