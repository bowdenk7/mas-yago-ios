//
//  MapViewController.swift
//  Yago
//
//  Created by Saim Jafar on 2/24/15.
//  Copyright (c) 2015 Team Socket Power. All rights reserved.
//

import UIKit
import MapKit
import MobileCoreServices

class MapViewController: CameraMenuItemController, CLLocationManagerDelegate, MKMapViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    var districts: [DistrictModel] = []
    var location: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 100.0  //how often manager is notified of view change
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        self.location = locationManager.location.coordinate
        getDistricts()
        let span = MKCoordinateSpanMake(0.5,0.5)
        mapView.setRegion(MKCoordinateRegionMake(location, span), animated: true)
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if annotation is BarDistrictAnnotation {
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            pinAnnotationView.canShowCallout = true
            
            let selectButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            selectButton.frame.size.width = 44
            selectButton.frame.size.height = 44
            selectButton.backgroundColor = UIColor.greenColor()
            
            pinAnnotationView.rightCalloutAccessoryView = selectButton
            return pinAnnotationView
        }
        return nil
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        if let annotation = view.annotation as? BarDistrictAnnotation {
            self.performSegueWithIdentifier("DistrictFeedSelected", sender: annotation)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DistrictFeedSelected" {
            if let annotation = sender as? BarDistrictAnnotation {
                let nextScene = segue.destinationViewController as DistrictFeedViewController
                let selectedDistrict = annotation.district
                nextScene.currentDistrict = selectedDistrict
            }
        }
    }
    
    func extractLocationFromString(locationString: String) -> CLLocationCoordinate2D {
        var pieces: [String] = locationString.componentsSeparatedByString(",")
        return CLLocationCoordinate2DMake((pieces[0] as NSString).doubleValue, (pieces[1] as NSString).doubleValue)
    }
    
    func getDistricts() {
        var districts:[DistrictModel] = []
        let manager = AFHTTPRequestOperationManager()
        var latLong = "\(String(self.location.latitude.description)),\(String(self.location.longitude.description))"
        manager.GET( API_BASE_URL + "feed/location_feed/\(latLong)",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                if let items = responseObject as? NSArray {
                    for item in items {
                        var positionResult = item["position"] as String
                        var feedItemName = item["name"] as String
                        var feedItemLocation = self.extractLocationFromString(item["position"] as String)
                        var feedItemId = item["pk"] as Int
                        var feedItem:DistrictModel = DistrictModel(
                            id: item["pk"] as Int,
                            name: feedItemName,
                            location: feedItemLocation
                        )
                        districts += [feedItem]
                        let annotation = BarDistrictAnnotation()
                        annotation.setCoordinate(feedItemLocation) //buckhead hard coded
                        annotation.title = feedItemName
                        annotation.district = DistrictModel(id: feedItemId, name: feedItemName, location: feedItemLocation)
                        self.mapView.addAnnotation(annotation)
                        self.mapView.selectAnnotation(annotation, animated: false)
                        
                        /**
                        The intended functionality here is to have every pin display their label. It appears iOS only allows one
                        pin to be selected at anytime. http://stackoverflow.com/questions/2417952/multiple-annotation-callouts-displaying-in-mkmapview
                        **/
                    }
                }
                self.districts = districts
                
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
    }
    

}
