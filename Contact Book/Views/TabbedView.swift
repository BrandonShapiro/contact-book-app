//
//  TabView.swift
//  Contact Book
//
//  Created by Brandon Shapiro on 8/6/22.
//

import SwiftUI

struct TabbedView: View {
    
    @EnvironmentObject var listViewModel : ListViewModel
    @Environment(\.dismiss) private var dismiss
    var contact: ContactModel
    
    var body: some View {
        TabView{
            EditContactView(contact: contact, first: contact.first, last: contact.last, address: contact.address, city: contact.city, state: contact.state, zip: contact.zip, phone: contact.phone, email: contact.email)
                .tabItem{
                    Label("Edit", systemImage: "square.and.pencil")
                }
            MapView(contact: contact)
                .tabItem{
                    Label("Map", systemImage: "map")
                }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TabbedView_Previews: PreviewProvider {
    static var contact = ContactModel(first: "Brandon", last: "Shapiro", address: "86 Country Spring Cir", city: "Kaysville", state: "UT", zip: "84037", phone: "3854248271", email: "brandonshapiro@mail.weber.edu")
    
    static var previews: some View {
        NavigationView{
            TabbedView(contact: contact)
                .environmentObject(ListViewModel())
        }
    }
}
