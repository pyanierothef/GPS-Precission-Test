//
//  LocationUpdate.swift
//  GPS Precission Test
//
//  Created by Pablo Yaniero on 9/8/18.
//  Copyright © 2018 Pablo Yaniero. All rights reserved.
//

import UIKit
import MapKit

class LocationUpdate: NSObject, MKAnnotation {
    
    let location : CLLocation
    let background : Bool
    
    var coordinate: CLLocationCoordinate2D {
        return location.coordinate
    }
    
    var timestamp: Double {
        return location.timestamp.timeIntervalSince1970
    }
    
    var speed : Double {
        return location.speed
    }
    
    init(_ location: CLLocation, background: Bool) {
        self.location = location
        self.background = background
    }
}

extension LocationUpdate : Recordable {
    func generateRecord() -> [RecordColumn : String] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        return [RecordColumn.timestamp: dateFormatter.string(from: Date(timeIntervalSince1970: timestamp)),
                RecordColumn.latitude: String(coordinate.latitude),
                RecordColumn.longitude: String(coordinate.longitude),
                RecordColumn.speed: String(speed),
                RecordColumn.background: String(background)]
    }
    
    func stringValue() -> String {
        return "\(String(timestamp)),\(String(coordinate.latitude)),\(String(coordinate.longitude)),\(String(speed)),\(String(background))"
    }
}
