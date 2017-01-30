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
    
    var treasureType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //customising map view
        
        
        let mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.styleURL = MGLStyle.lightStyleURL(withVersion: 9)
        mapView.tintColor = .lightGray

        mapView.zoomLevel = 10
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
 //       let coordinates = [
   //         CLLocationCoordinate2D(latitude: 0, longitude: 33),
 //           CLLocationCoordinate2D(latitude: 0, longitude: 66),
 //           CLLocationCoordinate2D(latitude: 0, longitude: 99),
            //pisa
   //         CLLocationCoordinate2D(latitude: 43.72305, longitude: 10.396633)
   //         ]
        
        // Fill an array with point annotations and add it to the map.
        
        // can fill the array with relevant items near the user and add to the map based on his/her location
        
  //      var pointAnnotations = [MGLPointAnnotation]()
        
    //    for coordinate in coordinates {
   //         let point = MGLPointAnnotation()
            //takes coordinates from coordinates array and add them to the MGLPointAnnotation array one by one through append
  //          point.coordinate = coordinate
            //change annotation label here
 //           point.title = "\(coordinate.latitude), \(coordinate.longitude)"
 //           point.subtitle = "Gold"
  //          pointAnnotations.append(point)
  //          print("this is it here \(point.title)")
  //      }
       
  //      mapView.addAnnotations(pointAnnotations)
        
        // begin single point annotation
        
        let point = MGLPointAnnotation()
        point.title = "Silver"
     //   point.subtitle = ""
        point.coordinate = CLLocationCoordinate2D(latitude: 43.72305, longitude: 10.396633)
        
        mapView.addAnnotation(point)
        
        //set treasureType to respective type (gold, silver or bronze)
        treasureType = point.title!
        
        mapView.userTrackingMode = .follow
        
       
    
    
    }
    
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        // get the custom reuse identifier for this annotation
        let reuseIdentifier = reuseIdentifierForAnnotation(annotation: annotation)
        // try to reuse an existing annotation image, if it exists
        var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: reuseIdentifier)
        
        // if the annotation image hasn‘t been used yet, initialize it here with the reuse identifier
        if annotationImage == nil {
            // lookup the image for this annotation
            var image = imageForAnnotation(annotation: annotation)
            image = image.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: image.size.height/2, right: 0))
            annotationImage = MGLAnnotationImage(image: image, reuseIdentifier: reuseIdentifier)
        }
        
        return annotationImage
    }
    
    // create a reuse identifier string with the coordinates
    func reuseIdentifierForAnnotation(annotation: MGLAnnotation) -> String {
        var reuseIdentifier = "\(annotation.coordinate.latitude),\(annotation.coordinate.longitude)"
        
        return reuseIdentifier
    }
    
    // lookup the image to load by switching on the annotation's title string
    
    func imageForAnnotation(annotation: MGLAnnotation) -> UIImage {
        var imageName = ""
        print("this is annotation title \(annotation.title)")
        if let title = annotation.title , title != nil {
            switch title! {
            case "Gold":
                imageName = "box2.png"
            case "Silver":
                imageName = "box2.png"
            case "Bronze":
                imageName = "box2.png"
            
            default:
                imageName = ""
            }
        }
        // ... etc.
        return UIImage(named: imageName)!
    }
    
    // MARK: - MGLMapViewDelegate methods
    
    // This delegate method is where you tell the map to load a view for a specific annotation. To load a static MGLAnnotationImage, you would use `-mapView:imageForAnnotation:`.
    
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    //add clickable icon on rightside of callout
    
    func mapView(_ mapView: MGLMapView, rightCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? {
        
        return UIButton(type: .detailDisclosure)
    }
    
    func mapView(_ mapView: MGLMapView, annotation: MGLAnnotation, calloutAccessoryControlTapped control: UIControl) {
        
        // Hide the callout view.
        mapView.deselectAnnotation(annotation, animated: false)
        
        //perform segue
        if treasureType == "Gold" {
            performSegue(withIdentifier: "goldSegue", sender:view)
            }
        
        if treasureType == "Silver" {
            performSegue(withIdentifier: "silverSegue", sender: view)
        }
        
        if treasureType == "Bronze" {
            performSegue(withIdentifier: "bronzeSegue", sender: view)
        }
        
        
        //add points to account
        
        //declare stored variable globally (e.g. accountPoints)
        
        //use if case loop
        
        // if let title = treasureType, title != nil {
        // switch title! {
        //  case "Gold":
        //      accountPoints += 100
        //  case "Silver":
        //      accountPoints += 75
        //  case "Bronze":
        //      accountPoints += 50
        // }
        
        // }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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








