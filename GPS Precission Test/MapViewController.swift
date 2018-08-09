//
//  MapViewController.swift
//  GPS Precission Test
//
//  Created by Pablo Yaniero on 9/8/18.
//  Copyright © 2018 Pablo Yaniero. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, LocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var location : LocationUpdate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: Notification.Name.UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)
        LocationManager.shared.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @objc func didEnterBackground () {
        LocationManager.shared.delegate = nil
    }

    @objc func willEnterForeground () {
        LocationManager.shared.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func locationManager(_ manager: LocationManager, didUpdateLocations locations: [LocationUpdate]) {
        
        centerMapOnLocation(location: locations.first!)
        
        location = locations.first
        
        for loc in locations {
            let annotation = LocationAnnotation(location: loc)
            
            self.mapView.addAnnotation(annotation)
        }

    }
    
    
    func centerMapOnLocation(location: LocationUpdate) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}
