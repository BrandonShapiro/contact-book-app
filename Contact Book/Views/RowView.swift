//
//  RowView.swift
//  Contact Book
//
//  Created by Brandon Shapiro on 8/6/22.
//

import SwiftUI

struct RowView: View {
    
    var contact : ContactModel
    
    var body: some View {
        HStack{
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 35, maxHeight: 35)
            VStack(alignment: .leading){
                Text(contact.first + " " + contact.last)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .accessibilityLabel("firstAndLastName")
                    .accessibilityValue("\(contact.first)" + " " + "\(contact.last)")
                Text(contact.phone)
                    .font(.subheadline)
            }
        }.padding()
    }
}

struct RowView_Previews: PreviewProvider {
    
    static var contact1 = ContactModel(first: "Brandon", last: "Shapiro", address: "Country Spring Cir", city: "Kaysville", state: "UT", zip: "84037", phone: "3854248271", email: "brandonshapiro9@gmail.com")
    static var contact2 = ContactModel(first: "Spenser", last: "Neel", address: "355 S Main St", city: "Kaysville", state: "UT", zip: "84037", phone: "8015468021", email: "spensneel13@gmail.com")
    
    static var previews: some View {
        Group{
            RowView(contact: contact1)
            RowView(contact: contact2)
        }.previewLayout(.sizeThatFits)
    }
}
