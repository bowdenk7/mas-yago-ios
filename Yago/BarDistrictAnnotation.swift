//
//  BarDistrictAnnotation.swift
//  Yago
//
//  Created by William Kelly on 3/7/15.
//  Copyright (c) 2015 Team Socket Power. All rights reserved.
//

import MapKit

class BarDistrictAnnotation : NSObject, MKAnnotation {
    private var coord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var district: DistrictModel!
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return coord
        }
    }
    
    var title: String = ""
    var subtitle: String = ""
    
    func setCoordinate(newCoordinate: CLLocationCoordinate2D) {
        self.coord = newCoordinate
    }
}
