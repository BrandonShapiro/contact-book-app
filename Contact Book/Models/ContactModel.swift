//
//  ContactModel.swift
//  Contact Book
//
//  Created by Brandon Shapiro on 8/6/22.
//

import Foundation
import MapKit

class ContactModel: Identifiable{
    
    let id: String
    let first: String
    let last: String
    let address: String
    let city: String
    let state: String
    let zip: String
    let phone: String
    let email: String
    var coordinates: CLLocationCoordinate2D?

    
    init(id: String = UUID().uuidString, first: String, last: String, address: String, city: String, state: String, zip: String, phone: String, email: String){
        self.id = id
        self.first = first
        self.last = last
        self.address = address
        self.city = city
        self.state = state
        self.zip = zip
        self.phone = phone
        self.email = email
        getLocation(from: address + ", " + city + ", " + state + " " + zip){coordinates in
            self.coordinates = coordinates
        }
        
    }
    
    func updateItem (newFirst:String, newLast:String, newAddress:String, newCity:String, newState:String, newZip:String, newPhone:String, newEmail:String) -> ContactModel {
        return ContactModel(id: id, first: newFirst, last: newLast, address: newAddress, city: newCity, state: newState, zip: newZip, phone: newPhone, email: newEmail)
    }
    
        
    func getLocation(from address: String, completion: @escaping (_ location: CLLocationCoordinate2D?)-> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks, let location = placemarks.first?.location?.coordinate else {
                completion(nil)
                return
            }
            completion(location)
        }
    }

}
