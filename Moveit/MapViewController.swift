//
//  MapViewController.swift
//  Moveit
//
//  Created by Kenny Ho on 15/1/17.
//  Copyright © 2017 Kenny Ho. All rights reserved.
//

import UIKit

import MapKit

import CoreLocation

import Mapbox


class MapViewController: UIViewController, MGLMapViewDelegate{
    
    var locationManager: CLLocationManager!
    var userLocation: CLLocationCoordinate2D! {
        didSet {
            
            mapView.setCenter(userLocation, animated: true)
            
        }
        
    }

  
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true

        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        isLocationUseAllowed()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MapViewController: CLLocationManagerDelegate {
    
    func isLocationUseAllowed() {
    
        switch CLLocationManager.authorizationStatus() {
    
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
    
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
    
        case .restricted, .denied:
            print("Access to Location Services Denied")
    
        default:
            print("unknown error")

        }
    
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        userLocation = locations.first?.coordinate
        
    }
    
}
