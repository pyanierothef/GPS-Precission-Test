//
//  ViewController.swift
//  GPS Precission Test
//
//  Created by Pablo Yaniero on 9/8/18.
//  Copyright © 2018 Pablo Yaniero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
@IBOutlet weak var startSignificant: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        LocationManager.shared.enableLocationServices()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func startSignificant(_ sender: Any) {
        LocationManager.shared.startReceivingSignificantLocationChanges()
    }
    
    @IBAction func startStandard(_ sender: Any) {
        LocationManager.shared.startReceivingLocationChanges()
    }
    @IBAction func startRegion(_ sender: Any) {
        LocationManager.shared.startReceivingRegionChanges()
    }
}

