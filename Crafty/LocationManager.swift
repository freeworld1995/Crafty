//
//  MapKit.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/2/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import MapKit

class LocationManager {
    struct Typealiases {
        typealias JSONDict = [String:Any]
    }
    
    let locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    func getAdress(completion: @escaping (Typealiases.JSONDict) -> ()) {
        
        locManager.requestWhenInUseAuthorization()
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locManager.location
            
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(currentLocation) { (placemarks, error) -> Void in
                
                if error != nil {
                    print("Error getting location: \(error)")
                } else {
                    let placeArray = placemarks as [CLPlacemark]!
                    var placeMark: CLPlacemark!
                    placeMark = placeArray?[0]
                    completion(placeMark.addressDictionary as! Typealiases.JSONDict)
                }
            }
        }
    }
}
