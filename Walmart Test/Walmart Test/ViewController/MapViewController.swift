//
//  MapViewController.swift
//  Walmart Test
//
//  Created by Consultant on 8/4/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    //TODO: Test user location more
    let locationManager = CLLocationManager()
    //MARK: Temporary user location for testing
    var userLocation = CLLocationCoordinate2D(latitude: 33.90883, longitude: -84.47905)
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        setUpMap()
        setUpStores()
    }
    
    func setUpMap() {
        
        let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
        
        let location = MKPointAnnotation()
        location.coordinate = userLocation
        location.title = "Your location"
        mapView.addAnnotation(location)
        
    }
    
    func setUpStores(){
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Walmart"
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: {(response, error) in
            
            if error != nil {
                print("Error occurred in search: \(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                print("No matches found")
            } else {
                print("Matches found")
                
                for item in response!.mapItems {
                    let store = MKPointAnnotation()
                    store.coordinate = item.placemark.coordinate
                    store.title = item.name!
                    store.subtitle = "Phone: \(item.phoneNumber!)"
                    //TODO: Customize annotation more
                    if item.url != nil {
                        store.subtitle = store.subtitle! + " \nWebsite: \(item.url!)"
                    }
                    
                    self.mapView.addAnnotation(store)
                }
            }
        })
    }
    

}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.first != nil {
            print("location:: (location)")
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
}


extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "annotationView")
        }
        annotationView?.image = UIImage(named: "pin")
        annotationView?.sizeToFit()
        annotationView?.canShowCallout = true
        return annotationView
    }
}
