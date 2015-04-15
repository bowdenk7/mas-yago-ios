//
//  CameraMenuItemController.swift
//  Yago
//
//  Created by William Kelly on 4/13/15.
//  Copyright (c) 2015 Team Socket Power. All rights reserved.
//

import UIKit
import MobileCoreServices

class CameraMenuItemController: UIViewController {
    
    @IBOutlet weak var cameraOverlay: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var cameraButton = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: "cameraPressed")
        self.navigationItem.rightBarButtonItem = cameraButton
    }
    
    func cameraPressed() {
        self.navigationController?.performSegueWithIdentifier("CameraSelected", sender: nil)
    }
    
}