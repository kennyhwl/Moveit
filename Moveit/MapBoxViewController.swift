//
//  MapBoxViewController.swift
//  Moveit
//
//  Created by Kenny Ho on 19/1/17.
//  Copyright © 2017 Kenny Ho. All rights reserved.
//

import UIKit
import Mapbox
//import CoreLocation


class MapBoxViewController: UIViewController, MGLMapViewDelegate {
    
    
    @IBOutlet weak var mapView: MGLMapView!
    
  //  var totalPoints = 0
  //  var facultyPoints = 0
    
    var locationManager: CLLocationManager!
    var userLocation: CLLocationCoordinate2D! {
        didSet {
            //centers the view on the user
            mapView.setCenter(userLocation, animated: true)
            
        }
        
    }
    
    //assume that quest is taken and "Accept" is clicked. Proceed to read user location and select JSON file entry and save treasure type to local memory
    
    //assume button is pressed
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //customising map view
        
        
        let mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.styleURL = MGLStyle.lightStyleURL(withVersion: 9)
        mapView.tintColor = .lightGray

       // mapView.zoomLevel = 5
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
        
       
        
        //begin location selection process
        
        struct userLocation {
            
            var longitude: Double
            var latitude: Double
        }
        
        struct itemLocation {
            
            var type: String
            var longitude: Double
            var latitude: Double
            
        }
        
        var myLocation = userLocation(longitude: 103.7555 , latitude: 1.3067)
        
        
        var tembusu = itemLocation(type: "Bronze", longitude: 103.7635, latitude: 1.3063)
        var cinnamon = itemLocation(type: "Silver", longitude: 103.7735, latitude: 1.3067 )
        var yale = itemLocation(type: "Gold", longitude: 103.7705 , latitude: 1.3006)
        var rc4 = itemLocation(type: " ", longitude: 103.7515, latitude: 1.3099)
        
        var locationDatabase = [tembusu, cinnamon, yale, rc4]
        print(locationDatabase.count)
        
        
        
        func getLocation(userLoc: userLocation, locDatabase: [itemLocation], upperR: Double, lowerR: Double) -> Array<itemLocation> {
            
            let longUser = userLoc.longitude
            let latUser = userLoc.latitude
            let locUser = CLLocation(latitude: latUser, longitude: longUser)
            var locsInRange: [itemLocation] = []
            var counter = -1
            
            for i in locDatabase {
                let longItem = i.longitude
                let latItem = i.latitude
                let locItem = CLLocation(latitude: latItem, longitude: longItem)
                let dist = locItem.distance(from: locUser)
                print("this is dist \(dist)")
                // if location is within desired range of user, add it to possible locations to assign array
                if (dist >= lowerR) && (dist <= upperR) {
                    locsInRange.append(i)
                    print ("this is locsInRange \(locsInRange)")
                    
                        counter += 1
                        // categorize them into three types
                        if (dist <= 0.333 * upperR){
                            locsInRange[counter].type = "Bronze"
                        }
                        if (dist <= 0.667 * upperR) && (dist > 0.333 * upperR){
                            locsInRange[counter].type = "Silver"
                        }
                        if (dist > 0.667 * upperR){
                            locsInRange[counter].type = "Gold"
                        }
                    
                
                }
                
            }
            
            print(locsInRange.count)
            let w = locsInRange.count - 1
            UserDefaults.standard.set(w, forKey: "setItemLoc")
            for i in 0...w{
                
                UserDefaults.standard.set(locsInRange[i].longitude, forKey: "\(i)Longitude")
                UserDefaults.standard.set(locsInRange[i].latitude, forKey: "\(i)Latitude")
            print("Helloooo \(locsInRange[i])")
            }
            let listLength = locsInRange.count
            let random = Int(arc4random_uniform(UInt32(listLength)))
            print ("this is random \(random)")
            //if we do not want user to choose
                //  return locsInRange[random]
            //if we allow user to choose
            return locsInRange
        }
        
        
        var selectedLocation = getLocation(userLoc: myLocation, locDatabase: locationDatabase, upperR: 1000, lowerR: 200)
        
        print("this is selected location: \(selectedLocation)")
        
        var pointAnnotations = [MGLPointAnnotation]()
        
        for i in selectedLocation {
        
            let point = MGLPointAnnotation()
            point.title = i.type
            point.subtitle = " "
            point.coordinate = CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude)
        
            pointAnnotations.append(point)
            
            //how to identify treasure type upon clicking collect??
            
            var treasureType = i.type
        
            UserDefaults.standard.set(treasureType, forKey: "\(i)whichTreasureType")
        
            mapView.addAnnotation(point)
        
        }
        
        
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
                imageName = "treasureboxgold.png"
            case "Silver":
                imageName = "treasureboxsilver.png"
            case "Bronze":
                imageName = "treasureboxbronze.png"
            
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
        
        //declarations
        
   //     let treasure = UserDefaults.standard.string(forKey: "whichTreasureType")
        
//        struct userLocation2 {
            
//            var longitude: Double
//            var latitude: Double
//        }
        
        
   //     let updatedLocation = CLLocation(latitude: 1.3067 , longitude: 103.7555)
        
        
  //      let w = UserDefaults.standard.integer(forKey: "setItemLoc")
        
  //      var itemLocation: [CLLocation] = []
        
  //      for i in 0...w{
            
  //          var counter = -1
  //          counter += 1
            
  //          var itemLocLa = UserDefaults.standard.double(forKey: "\(counter)Latitude")
  //          var itemLocLo = UserDefaults.standard.double(forKey: "\(counter)Longitude")
            
   //         itemLocation[counter] = CLLocation(latitude: itemLocLa, longitude: itemLocLo)
            
   //     }
        
  //      var distanceArray: [Double] = []
        
  //      for i in itemLocation {
            
   //         let dist = i.distance(from: updatedLocation)
   //         distanceArray[i] = dist
            
  //      }
        
        // check if user is within 10 meters
        
        let locUser = CLLocation(latitude: 1.3067 , longitude: 103.7555)
        // let locUser = CLLocation(latitude: 1.3063, longitude: 103.7635)
        let locItem = annotation.coordinate
        let longItem = locItem.longitude
        let latItem = locItem.latitude
        let locItemNew = CLLocation(latitude: latItem, longitude: longItem)
        let distCheck = locItemNew.distance(from: locUser)
        
        if (distCheck <= 50) {
            
        
            // perform segue based on annotation title & give points
        
            if let treasure = annotation.title, treasure != nil {
            
                switch treasure! {
                
                case "Gold":
                    performSegue(withIdentifier: "goldSegue", sender:view)
                    let pointsToGive = 100
                    
                    let addPoints = pointsToGive
                    let oldPoints = UserDefaults.standard.integer(forKey: "accountPoints")
                    let newPoints = oldPoints + addPoints
                    
                    let addFacultyPoints = pointsToGive
                    let oldFacultyPoints = UserDefaults.standard.integer(forKey: "facultyPoints")
                    let newFacultyPoints = oldFacultyPoints + addFacultyPoints
                    UserDefaults.standard.set(newPoints, forKey: "accountPoints")
                    UserDefaults.standard.set(newFacultyPoints, forKey: "facultyPoints")
                
                case "Silver":
                    performSegue(withIdentifier: "silverSegue", sender: view)
                    let pointsToGive = 75
                    
                    let addPoints = pointsToGive
                    let oldPoints = UserDefaults.standard.integer(forKey: "accountPoints")
                    let newPoints = oldPoints + addPoints
                    
                    let addFacultyPoints = pointsToGive
                    let oldFacultyPoints = UserDefaults.standard.integer(forKey: "facultyPoints")
                    let newFacultyPoints = oldFacultyPoints + addFacultyPoints
                    UserDefaults.standard.set(newPoints, forKey: "accountPoints")
                    UserDefaults.standard.set(newFacultyPoints, forKey: "facultyPoints")
            
                case "Bronze":
                    performSegue(withIdentifier: "bronzeSegue", sender: view)
                    let pointsToGive = 50
                    
                    let addPoints = pointsToGive
                    let oldPoints = UserDefaults.standard.integer(forKey: "accountPoints")
                    let newPoints = oldPoints + addPoints
                    
                    let addFacultyPoints = pointsToGive
                    let oldFacultyPoints = UserDefaults.standard.integer(forKey: "facultyPoints")
                    let newFacultyPoints = oldFacultyPoints + addFacultyPoints
                    UserDefaults.standard.set(newPoints, forKey: "accountPoints")
                    UserDefaults.standard.set(newFacultyPoints, forKey: "facultyPoints")
            
                default:
                    performSegue(withIdentifier: "backSegue", sender: view)
                }
            
            }
        } else {
            
            let notice = "Notice"
            let message = "Sorry, you are too far from the item's location!"
            let ac = UIAlertController(title: notice, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
        
        
        
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








