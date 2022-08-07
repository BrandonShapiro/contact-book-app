//
//  AddContactView.swift
//  Contact Book
//
//  Created by Brandon Shapiro on 8/6/22.
//

import SwiftUI

struct AddContactView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var listViewModel : ListViewModel
    
    @State var newFirst: String
    @State var newLast: String
    @State var newAddress: String
    @State var newCity: String
    @State var newState: String
    @State var newZip: String
    @State var newPhone: String
    @State var newEmail: String
    
    var body: some View {
        VStack {
            HStack{
                Button("Cancel"){
                    dismiss()
                }
                Spacer()
                Button("Save"){
                    listViewModel.createContact(newFirst: newFirst, newLast: newLast, newAddress: newAddress, newCity: newCity, newState: newState, newZip: newZip, newPhone: newPhone, newEmail: newEmail)
                    dismiss()
                }
            }.padding()
            List{
                Section(header: Label("Name", systemImage: "person.fill")){
                    HStack{
                        Text("First Name: ")
                        TextField("ex: John", text: $newFirst)
                            .accessibilityLabel("addFirstName")
                            .accessibilityValue("\(newFirst)")
                    }
                    HStack {
                        Text("Last Name: ")
                        TextField("ex: Doe", text: $newLast)
                            .accessibilityIdentifier("addLastName")
                            .accessibilityValue("\(newLast)")
                    }
                }
                Section(header: Label("Address", systemImage: "house.fill")){
                    HStack {
                        Text("Address: ")
                        TextField("ex: 123 Main St", text: $newAddress)
                            .accessibilityIdentifier("addAddress")
                            .accessibilityValue("\(newAddress)")
                    }
                    HStack {
                        Text("City: ")
                        TextField("ex: Ogden", text: $newCity)
                            .accessibilityIdentifier("addCity")
                            .accessibilityValue("\(newCity)")
                    }
                    HStack {
                        Text("State: ")
                        TextField("ex: UT", text: $newState)
                            .accessibilityIdentifier("addState")
                            .accessibilityValue("\(newState)")
                    }
                    HStack {
                        Text("Zip Code: ")
                        TextField("ex: 84401", text: $newZip)
                            .accessibilityIdentifier("addZipCode")
                            .accessibilityValue("\(newZip)")
                    }
                }
                Section(header: Label("Contact Info", systemImage: "phone.fill")){
                    HStack {
                        Text("Phone Number: ")
                        TextField("ex: (123) 456-7890", text: $newPhone)
                            .accessibilityIdentifier("addPhone")
                            .accessibilityValue("\(newPhone)")
                    }
                    HStack {
                        Text("Email Address: ")
                        TextField("ex: example@domain.com", text: $newEmail)
                            .accessibilityIdentifier("addEmail")
                            .accessibilityValue("\(newEmail)")
                    }
                }
            }.listStyle(.grouped)
            Spacer()
        }
        .navigationTitle("Add New Contact")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

struct AddContactView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView{
            AddContactView(newFirst: "", newLast: "", newAddress: "", newCity: "", newState: "", newZip: "", newPhone: "", newEmail: "")
                .environmentObject(ListViewModel())
        }
    }
}
