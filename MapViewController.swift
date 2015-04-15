//
//  MapViewController.swift
//  Yago
//
//  Created by Chad Collins on 2/24/15.
//  Copyright (c) 2015 Team Socket Power. All rights reserved.
//

import UIKit
import MapKit
import MobileCoreServices

class MapViewController: CameraMenuItemController, CLLocationManagerDelegate, MKMapViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    
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
        
        //Annotations
        let annotation = BarDistrictAnnotation()
        annotation.setCoordinate(CLLocationCoordinate2DMake(33.839451, -84.380104)) //buckhead hard coded
        annotation.title = "Buckhead"

        mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: false) //NOTE: THIS IS TEMPORARY see below
        
        /**
        The intended functionality here is to have every pin display their label. It appears iOS only allows one
        pin to be selected at anytime. http://stackoverflow.com/questions/2417952/multiple-annotation-callouts-displaying-in-mkmapview
        **/

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locationManager.location.coordinate
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
            self.performSegueWithIdentifier("DistrictFeedSelected", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DistrictFeedSelected" {
            let nextScene = segue.destinationViewController as DistrictFeedViewController
            //For now
            let selectedDistrict = DistrictModel(id: 1, name: "Buckhead")
            nextScene.currentDistrict = selectedDistrict
        }
    }
    
    
    

}
