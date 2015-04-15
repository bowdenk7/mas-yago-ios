//
//  DistrictFeedItem.swift
//  Yago
//
//  Created by William Kelly on 3/26/15.
//  Copyright (c) 2015 Team Socket Power. All rights reserved.
//

import Foundation

class DistrictModel {

    var id: Int = 0
    var name: String = ""
    var location: CLLocationCoordinate2D!

    init(id: Int, name: String, location: CLLocationCoordinate2D) {
        self.id = id
        self.name = name
        self.location = location
    }
    
}
