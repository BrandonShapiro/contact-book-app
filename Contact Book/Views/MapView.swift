//
//  MapView.swift
//  Contact Book
//
//  Created by Brandon Shapiro on 8/6/22.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {

    @EnvironmentObject private var vm : ListViewModel
    var contact: ContactModel
    
    var body: some View {
        
        VStack(alignment: .center){
            VStack{
                Text("\(contact.first) \(contact.last)")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("\(contact.address), \(contact.city), \(contact.state) \(contact.zip)")
            }
            HStack{
                Map(coordinateRegion: $vm.mapRegion,
                    annotationItems: vm.contactList,
                    annotationContent: {contact in
                    MapMarker(coordinate: contact.coordinates ?? CLLocationCoordinate2D(latitude: 41.1916380244206, longitude: -111.94397917339016)) //default location is WSU
                })
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var contact: ContactModel = ContactModel(first: "Brandon", last: "Shapiro", address: "86 Country Spring Cir", city: "Kaysville", state: "UT", zip: "84037", phone: "3854248271", email: "brandonshapiro9@gmail.com")

    static var previews: some View {
        NavigationView{
            MapView(contact: contact)
                .environmentObject(ListViewModel())
        }
    }
}
