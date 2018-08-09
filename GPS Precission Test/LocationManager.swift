//
//  LocationManager.swift
//  GPS Precission Test
//
//  Created by Pablo Yaniero on 9/8/18.
//  Copyright © 2018 Pablo Yaniero. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate {
    func locationManager(_ manager: LocationManager,  didUpdateLocations locations: [LocationUpdate])
}

class LocationManager : NSObject, CLLocationManagerDelegate {
    
let locationManager = CLLocationManager()
var inBackground = false
static let shared = LocationManager()

var delegate : LocationManagerDelegate?

    let recorder = Recorder()

override init() {
    super.init()
    NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: Notification.Name.UIApplicationDidEnterBackground, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)
    recorder.setUpRecord();
}
    
@objc func didEnterBackground () {
    inBackground = true
}

@objc func willEnterForeground () {
    inBackground = false
}
    
func enableLocationServices() {
    locationManager.delegate = self
    
    switch CLLocationManager.authorizationStatus() {
    case .notDetermined:
        // Request when-in-use authorization initially
        locationManager.requestAlwaysAuthorization()
        break
        
    case .restricted, .denied:
        // Disable location features

        break
        
    case .authorizedWhenInUse:
        // Enable basic location features
        
        break
        
    case .authorizedAlways:
        // Enable any of your app's location features
    
        break
    }
}
    
func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {   switch status {
    case .restricted, .denied:
        // Disable your app's location features
        break
        
    case .authorizedWhenInUse:
        // Enable only your app's when-in-use features.

        break
        
    case .authorizedAlways:
        // Enable any of your app's location services.

        break
        
    case .notDetermined:
        break
    }
}
    
    func startReceivingSignificantLocationChanges() {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus != .authorizedAlways {
            // User has not authorized access to location information.
            return
        }
        
        if !CLLocationManager.significantLocationChangeMonitoringAvailable() {
            // The service is not available.
            return
        }
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func startReceivingLocationChanges() {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus != .authorizedWhenInUse && authorizationStatus != .authorizedAlways {
            // User has not authorized access to location information.
            return
        }
        // Do not start services that aren't available.
        if !CLLocationManager.locationServicesEnabled() {
            // Location services is not available.
            return
        }
        // Configure and start the service.
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
       // locationManager.distanceFilter = 10  // In meters.
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        
        let locationUpdates = locations.map { loc -> LocationUpdate in
            let location = LocationUpdate(loc, background: inBackground)
            recorder.record(r: location)
            return location
        }
        
        guard let delegate = delegate else {
            return
        }
        
        delegate.locationManager(self, didUpdateLocations:locationUpdates)
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            // Location updates are not authorized.
            manager.stopMonitoringSignificantLocationChanges()
            return
        }
        // Notify the user of any errors.
    }
    
}
