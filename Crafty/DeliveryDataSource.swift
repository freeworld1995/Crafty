//
//  DeliveryDataSource.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/27/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import GooglePlaces

class DeliveryDataSource: NSObject, UITableViewDataSource, CLLocationManagerDelegate {
    
    var placesClient: GMSPlacesClient!
    var likeHoodList: GMSPlaceLikelihoodList?
    var locationManager: CLLocationManager!
    
    override init() {
        super.init()
        askForAuth()
    }
    
    func askForAuth() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("did update location")
    }
    
    func fetchNearbyPlaces(completion: @escaping () -> ()) {
        
        placesClient = GMSPlacesClient.shared()
        
        placesClient.currentPlace { [unowned self] (placeLikelihoodList, error) in
            if let error = error {
                print("pick place error: \(error.localizedDescription)")
                return
            }
            
            if let placeLikelihoodList = placeLikelihoodList {
                self.likeHoodList = placeLikelihoodList
                completion()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let likeHoodList = likeHoodList {
            return likeHoodList.likelihoods.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LocationTableViewCell
        let place = likeHoodList?.likelihoods[indexPath.row].place
        //https://developers.google.com/places/ios-api/reference/interface_g_m_s_place
        cell.textLabel?.text = place?.name
        cell.detailTextLabel?.text = place?.formattedAddress

        return cell
    }
    
}
