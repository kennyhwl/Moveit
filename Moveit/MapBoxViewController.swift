//
//  MapBoxViewController.swift
//  Moveit
//
//  Created by Kenny Ho on 19/1/17.
//  Copyright © 2017 Kenny Ho. All rights reserved.
//

import UIKit
import Mapbox


class MapBoxViewController: UIViewController, MGLMapViewDelegate {


    @IBOutlet weak var mapView: MGLMapView!
    
    var locationManager: CLLocationManager!
    var userLocation: CLLocationCoordinate2D! {
        didSet {
            //centers the view on the user
            mapView.setCenter(userLocation, animated: true)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //customising map view
        
        
        let mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.styleURL = MGLStyle.lightStyleURL(withVersion: 9)
        mapView.tintColor = .lightGray
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: 0, longitude: 66)
        mapView.zoomLevel = 2
        mapView.delegate = self
        view.addSubview(mapView)
        
        //show user location
        mapView.showsUserLocation = true
        //where is user
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        isLocationUseAllowed()
        
        // Specify coordinates for our annotations.
        // can input coordinates from json file
        let coordinates = [
            CLLocationCoordinate2D(latitude: 0, longitude: 33),
            CLLocationCoordinate2D(latitude: 0, longitude: 66),
            CLLocationCoordinate2D(latitude: 0, longitude: 99),
            ]
        
        // Fill an array with point annotations and add it to the map.
        // can fill the array with relevant items near the user and add to the map based on his/her location
        
        var pointAnnotations = [MGLPointAnnotation]()
        for coordinate in coordinates {
            let point = MGLPointAnnotation()
            //takes coordinates from coordinates array and add them to the MGLPointAnnotation array one by one through append
            point.coordinate = coordinate
            //change annotation label here
            point.title = "\(coordinate.latitude), \(coordinate.longitude)"
            pointAnnotations.append(point)
        }
        
        mapView.addAnnotations(pointAnnotations)
        

    }
    
    // MARK: - MGLMapViewDelegate methods
    
    // This delegate method is where you tell the map to load a view for a specific annotation. To load a static MGLAnnotationImage, you would use `-mapView:imageForAnnotation:`.
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        // This example is only concerned with point annotations.
        guard annotation is MGLPointAnnotation else {
            return nil
        }
        
        // Use the point annotation’s longitude value (as a string) as the reuse identifier for its view.
        let reuseIdentifier = "\(annotation.coordinate.longitude)"
        
        // For better performance, always try to reuse existing annotations.
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        // If there’s no reusable annotation view available, initialize a new one.
        if annotationView == nil {
            annotationView = CustomAnnotationView(reuseIdentifier: reuseIdentifier)
            annotationView!.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            
            // Set the annotation view’s background color to a value determined by its longitude.
            let hue = CGFloat(annotation.coordinate.longitude) / 100
            annotationView!.backgroundColor = UIColor(hue: hue, saturation: 0.5, brightness: 1, alpha: 1)
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//
// MGLAnnotationView subclass
class CustomAnnotationView: MGLAnnotationView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Force the annotation view to maintain a constant size when the map is tilted.
        scalesWithViewingDistance = false
        
        // Use CALayer’s corner radius to turn this view into a circle.
        layer.cornerRadius = frame.width / 2
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Animate the border width in/out, creating an iris effect.
        let animation = CABasicAnimation(keyPath: "borderWidth")
        animation.duration = 0.1
        layer.borderWidth = selected ? frame.width / 4 : 2
        layer.add(animation, forKey: "borderWidth")
    }
}

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

extension MapBoxViewController: CLLocationManagerDelegate {
    
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








