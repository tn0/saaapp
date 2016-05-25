//
//  BaseConfigViewController.swift
//  SAA
//
//  Created by Thomas Nowak on 17.7.14.
//  Copyright (c) 2014 COMLINE AG. All rights reserved.
//

import UIKit

class BaseConfigViewController: BaseViewController {

    var filter:Filter
    init(_filter:Filter)
    {
        Debug.print("BaseConfigViewController::init")

        filter=_filter
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        Debug.print("BaseConfigViewController::viewDidLoad")
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        Debug.print("BaseConfigViewController::didReceiveMemoryWarning")
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
