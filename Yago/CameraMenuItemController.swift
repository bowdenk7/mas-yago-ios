//
//  CameraMenuItemController.swift
//  Yago
//
//  Created by William Kelly on 4/13/15.
//  Copyright (c) 2015 Team Socket Power. All rights reserved.
//

import UIKit
import MobileCoreServices

class CameraMenuItemController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var cameraOverlay: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var cameraButton = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: "cameraPressed")
        self.navigationItem.rightBarButtonItem = cameraButton
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject: AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as UIImage
        createPost(image)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func createPost(image: UIImage) {
        var imageData = UIImagePNGRepresentation(image)
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        var params : Dictionary = ["position": "10,10", "venue": "1"]
        manager.POST( API_BASE_URL + "post/",
            parameters: params,
            constructingBodyWithBlock: {(data: AFMultipartFormData!) in
                data.appendPartWithFileData(imageData, name: "image", fileName: "newImage.png", mimeType: "image/png")
            },
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                println("Image posted!")
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
        
    }
    
    func cameraPressed() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            var cameraController = UIImagePickerController()
            cameraController.delegate = self
            cameraController.sourceType = UIImagePickerControllerSourceType.Camera
            
            let mediaTypes:[AnyObject] = [kUTTypeImage]
            cameraController.mediaTypes = mediaTypes
            cameraController.allowsEditing = false
            NSBundle.mainBundle().loadNibNamed("CameraOverlay", owner: self, options: nil)[0]
            self.cameraOverlay!.frame = cameraController.cameraOverlayView!.frame
            cameraController.cameraOverlayView = self.cameraOverlay
            self.cameraOverlay = nil
            

            
            self.presentViewController(cameraController, animated: true, completion: nil)
        } else if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            var libraryController = UIImagePickerController()
            libraryController.delegate = self
            libraryController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            let mediaTypes:[AnyObject] = [kUTTypeImage]
            libraryController.mediaTypes = mediaTypes
            libraryController.allowsEditing = false
            
            self.presentViewController(libraryController, animated: true, completion: nil)
        } else {
            var alertController = UIAlertController(title: "Alert", message: "This app needs either the camera or photo library to function correctly", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
}