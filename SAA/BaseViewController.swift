//
//  BaseViewComntroller.swift
//  SAA
//
//  Created by Thomas Nowak on 8.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
       
        
        Debug.print("BaseViewController::TranslatesAutoresizingMaskIntoConstraints \(view.translatesAutoresizingMaskIntoConstraints()) \(self.debugDescription)")
        
        // Custom initialization
    }
    
    
    override init()
    {
        super.init(nibName:nil , bundle:nil)
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
     view.setTranslatesAutoresizingMaskIntoConstraints(false)   
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        Debug.print(" \(self.description) ---> View \(view.frame.width) x \(view.frame.height) ")
    }
    func addChild(childController: UIViewController!) {
        addChildViewController(childController)
        Debug.print("BaseViewController::addChild add \(childController.view.debugDescription) to \(self.description)")
        view.addSubview(childController.view)
        childController.didMoveToParentViewController(self)
    }
    
    func addChildToSubView(childController: UIViewController!,view:UIView) {
        addChildViewController(childController)
        Debug.print("BaseViewController::addChildToSubView add \(childController.view.debugDescription) to \(view.description)")
        view.addSubview(childController.view)
        childController.didMoveToParentViewController(self)
    }
    func removeChild(childController:UIViewController) {
        Debug.print("\(self) removeChild controller \(childController)")
        childController.willMoveToParentViewController(self)
        childController.view.removeFromSuperview();
        childController.removeFromParentViewController()
    }
    
    
    func removeAllSubViews() {
        var subview:UIView?;
     
        for   curview : AnyObject in view.subviews {
            if( curview is UIView)
            {
                curview.removeFromSuperview()
            }
        }
    }
    
    func removeAllSubViewsfromView(view:UIView) {
        var subview:UIView?;
        
        for   curview : AnyObject in view.subviews {
            if( curview is UIView)
            {
                curview.removeFromSuperview()
            }
        }
    }
    func removeAllChilds() {
        
        
        for   controller  in childViewControllers {
            removeChild(controller as UIViewController)
        }
    }


}
