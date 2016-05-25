//
//  BaseViewComntroller.swift
//  SAA
//
//  Created by Thomas Nowak on 8.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    
    init()
    {
        Debug.print("BaseViewController::init")
        super.init(nibName:nil , bundle:nil)
     
        //view.translatesAutoresizingMaskIntoConstraints=false
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad()
    {
        Debug.print("BaseViewController::viewDidLoad")
        super.viewDidLoad()
      view.translatesAutoresizingMaskIntoConstraints=false
    }
    
    override func viewDidLayoutSubviews()
    {
        
        Debug.print("BaseViewController::viewDidLayoutSubviews")
        super.viewDidLayoutSubviews()
        Debug.print(" \(self.description) ---> View \(view.frame.width) x \(view.frame.height) ")

    }
    func addChild(childController: UIViewController!) {
        
    Debug.print("BaseViewController::addChild")
        addChildViewController(childController)
        Debug.print("BaseViewController::addChild add \(childController.view.debugDescription) to \(self.description)")
        view.addSubview(childController.view)
        childController.didMoveToParentViewController(self)
    }
    
    func addChildToSubView(childController: UIViewController!,view:UIView) {
        Debug.print("BaseViewController::addChildToSubView")
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
    Debug.print("BaseViewController::removeAllSubViews")
       // var subview:UIView?;
     
        for   curview : AnyObject in view.subviews {
            if( curview is UIView)
            {
                curview.removeFromSuperview()
            }
        }
    }
    
    func removeAllSubViewsfromView(view:UIView) {
        Debug.print("BaseViewController::removeAllSubViewsfromView")
    //    var subview:UIView?;
        
        for   curview : AnyObject in view.subviews {
            if( curview is UIView)
            {
                curview.removeFromSuperview()
            }
        }
    }
    func removeAllChilds() {
        Debug.print("BaseViewController::removeAllChilds")
        for   controller  in childViewControllers {
            removeChild(controller as UIViewController)
        }
    }


}
