//
//  GlobalSplitViewController.swift
//  Sint-Petrus
//
//  Created by Seppe Devogelaere on 26/12/15.
//  Copyright © 2015 Seppe Devogelaere. All rights reserved.
//


import UIKit

// Source: http://stackoverflow.com/questions/25875618/uisplitviewcontroller-in-portrait-on-iphone-shows-detail-vc-instead-of-master
class GlobalSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool{
        return true
    }
    
}