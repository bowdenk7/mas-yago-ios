//
//  VenueSelectionController.swift
//  Yago
//
//  Created by William Kelly on 4/14/15.
//  Copyright (c) 2015 Team Socket Power. All rights reserved.
//

import MobileCoreServices

class VenueSelectionController: UITableViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var locationManager: CLLocationManager!
    var location: CLLocation!
    var venues: [BarModel]!
    var selectedVenue: BarModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100.0  //how often manager is notified of view change
        locationManager.startUpdatingLocation()
        venues = []
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.venues.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        cell.textLabel?.text = self.venues[indexPath.row].name
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedVenue = venues[indexPath.row]
        invokeCamera()
    }
    
    func getBarsByProximity() {
        var venues:[BarModel] = []
        let manager = AFHTTPRequestOperationManager()
        var latLong = "\(String(self.location.coordinate.latitude.description)),\(String(self.location.coordinate.longitude.description))"
        println("Fetching venues at \(latLong)")
        manager.GET( API_BASE_URL + "post/closest_venues/\(latLong)",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                if let items = responseObject as? NSArray {
                    for item in items {
                        var feedItem:BarModel = BarModel(name: item["name"] as String,
                            imageUrl: item["logo_url"] as String,
                            id: item["pk"]as Int)
                        venues += [feedItem]
                    }
                }
                self.venues = venues
                self.tableView.reloadData()
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        self.location = locationManager.location
        getBarsByProximity()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject: AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage]as UIImage
        createPost(image)
        self.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func createPost(image: UIImage) {
        var imageData = UIImageJPEGRepresentation(image, 0.0)
        let manager = AFHTTPRequestOperationManager()
        var latLong = "\(String(self.location.coordinate.latitude.description)),\(String(self.location.coordinate.longitude.description))"
        manager.responseSerializer = AFJSONResponseSerializer()
        var params : Dictionary = ["position": "\(latLong)", "venue": "\(selectedVenue.id)"]
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
    
    func invokeCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            var cameraController = UIImagePickerController()
            cameraController.delegate = self
            cameraController.sourceType = UIImagePickerControllerSourceType.Camera
        
            let mediaTypes:[AnyObject] = [kUTTypeImage]
            cameraController.mediaTypes = mediaTypes
            cameraController.allowsEditing = false
//            NSBundle.mainBundle().loadNibNamed("CameraOverlay", owner: self, options: nil)[0]
//            self.cameraOverlay!.frame = cameraController.cameraOverlayView!.frame
//            cameraController.cameraOverlayView = self.cameraOverlay
//            self.cameraOverlay = nil
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
