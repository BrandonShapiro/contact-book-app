//
//  ListViewModel.swift
//  Contact Book
//
//  Created by Brandon Shapiro on 8/6/22.
//

import Foundation
import MapKit

class ListViewModel: ObservableObject {
    
    //all contacts
    @Published var contactList: [ContactModel] = [ContactModel(first: "Weber State", last: "University", address: "3848 Harrison Blvd", city: "Ogden", state: "UT", zip: "84408", phone: "1234567890", email: "webermail@mail.weber.edu")]
    
    //current contact location
    var currentContact: ContactModel?{
        didSet{
            updateMapRegion(contact: currentContact!)
        }
    }
    
    //region shown on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    //span (for map)
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
    
    init(){
        self.contactList = contactList
        self.currentContact = contactList.first!
        self.updateMapRegion(contact: contactList.first!)
    }
    
    //function to update the location
    func updateCurrentContact(contact: ContactModel){
        currentContact = contact
        //print("Current contact updated to: \(contact.first) \(contact.last)")
    }
    
    //function to update the map region based on which Contact is passed in
    func updateMapRegion(contact: ContactModel) {
        if contact.coordinates != nil {
            mapRegion = MKCoordinateRegion(center: contact.coordinates!, span: mapSpan)
        }
        else{
            mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.1916380244206, longitude: -111.94397917339016), span: mapSpan) //unrecognized addresses simply show WSU
        }
    }
    
    //ADD NEW Contact
    func createContact(newFirst: String, newLast: String, newAddress: String, newCity: String, newState: String, newZip: String, newPhone: String, newEmail: String){
        let newContact = ContactModel(first: newFirst, last: newLast, address: newAddress, city: newCity, state: newState, zip: newZip, phone: newPhone, email: newEmail)
        contactList.append(newContact)
    }
    
    //EDIT existing Contact
    func updateContact(contact: ContactModel, newFirst: String, newLast: String, newAddress: String, newCity: String, newState: String, newZip: String, newPhone: String, newEmail: String){
        if let index = contactList.firstIndex(where: {$0.id == contact.id}){
            contactList[index] = contact.updateItem(newFirst: newFirst, newLast: newLast, newAddress: newAddress, newCity: newCity, newState: newState, newZip: newZip, newPhone: newPhone, newEmail: newEmail)
        }
    }
    
    //DELETE a Contact
    func deleteContact(indexSet: IndexSet){
        contactList.remove(atOffsets: indexSet)
    }
    
}
