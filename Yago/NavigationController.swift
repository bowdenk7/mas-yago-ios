//
//  NavigationController.swift
//  Yago
//
//  Created by William Kelly on 4/14/15.
//  Copyright (c) 2015 Team Socket Power. All rights reserved.
//

import Foundation

class NavigationController: UINavigationController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var cameraButton = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: "cameraPressed")
        self.topViewController.navigationItem.rightBarButtonItem = cameraButton
        println("Nav controller loaded")
    }
    
    func cameraPressed() {
        self.performSegueWithIdentifier("CameraSelected", sender: nil)
    }
    
}