//
//  EditContactView.swift
//  Contact Book
//
//  Created by Brandon Shapiro on 8/6/22.
//

import SwiftUI

struct EditContactView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var listViewModel : ListViewModel
    
    var contact: ContactModel
    @State var first: String = ""
    @State var last : String = ""
    @State var address : String = ""
    @State var city : String = ""
    @State var state : String = ""
    @State var zip : String = ""
    @State var phone : String = ""
    @State var email : String = ""
    
    var body: some View {
        VStack{
            HStack{
                Button("Cancel"){
                    dismiss()
                }
                Spacer()
                Text("Edit Contact")
                    .font(.headline)
                    .fontWeight(.semibold)
                    
                    
                Spacer()
                Button("Save") {
                    listViewModel.updateContact(contact: contact, newFirst: first, newLast: last, newAddress: address, newCity: city, newState: state, newZip: zip, newPhone: phone, newEmail: email)
                    dismiss()
                }
                
            }
                .multilineTextAlignment(.center)
                .padding()
            List{
                Section(header: Label("Name", systemImage: "person.fill")){
                    HStack{
                        Text("First Name: ")
                        TextField("ex: John", text: $first)
                            .accessibilityLabel("editFirstName")
                            .accessibilityValue("\(first)")
                    }
                    HStack {
                        Text("Last Name: ")
                        TextField("ex: Doe", text: $last)
                            .accessibilityIdentifier("editLastName")
                            .accessibilityValue("\(last)")
                    }
                }
                Section(header: Label("Address", systemImage: "house.fill")){
                    HStack {
                        Text("Address: ")
                        TextField("ex: 123 Main St", text: $address)
                            .accessibilityIdentifier("editAddress")
                            .accessibilityValue("\(address)")
                    }
                    HStack {
                        Text("City: ")
                        TextField("ex: Ogden", text: $city)
                            .accessibilityIdentifier("editCity")
                            .accessibilityValue("\(city)")
                    }
                    HStack {
                        Text("State: ")
                        TextField("ex: UT", text: $state)
                            .accessibilityIdentifier("editState")
                            .accessibilityValue("\(state)")
                    }
                    HStack {
                        Text("Zip Code: ")
                        TextField("ex: 84041", text: $zip)
                            .accessibilityIdentifier("editZipCode")
                            .accessibilityValue("\(zip)")
                    }
                }
                Section(header: Label("Contact Info", systemImage: "phone.fill")){
                    HStack {
                        Text("Phone Number: ")
                        TextField("ex: (123) 456-7890", text: $phone)
                            .accessibilityIdentifier("editPhone")
                            .accessibilityValue("\(phone)")
                    }
                    HStack {
                        Text("Email Address: ")
                        TextField("ex: example@domain.com", text: $email)
                            .accessibilityIdentifier("editEmail")
                            .accessibilityValue("\(email)")
                    }
                }
            }.listStyle(.grouped)
            Spacer()
        }
    }
}


struct EditContactView_Previews: PreviewProvider {
    
    static var contact1 = ContactModel(first: "", last: "", address: "", city: "", state: "", zip: "", phone: "", email: "")
    
    static var previews: some View {
        NavigationView{
            TabView{
            EditContactView(contact: contact1)
                .environmentObject(ListViewModel())
            }
        }
    }
}
