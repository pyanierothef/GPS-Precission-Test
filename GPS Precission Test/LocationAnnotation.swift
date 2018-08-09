//
//  LocationAnnotation.swift
//  GPS Precission Test
//
//  Created by Pablo Yaniero on 9/8/18.
//  Copyright © 2018 Pablo Yaniero. All rights reserved.
//

import UIKit
import MapKit

class LocationAnnotation: NSObject, MKAnnotation {
    let location : LocationUpdate
    
    var title: String? {
        return String(location.timestamp)
    }
    
    var subtitle: String? {
        return String(location.speed)
    }
    
    var coordinate: CLLocationCoordinate2D {
        return location.coordinate
    }
    
    init(location: LocationUpdate) {
        self.location = location
    }
}
