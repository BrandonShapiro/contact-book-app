//
//  ListView.swift
//  Contact Book
//
//  Created by Brandon Shapiro on 8/6/22.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel : ListViewModel
    
    var body: some View {
        
            List{
                ForEach(listViewModel.contactList){contact in
                    NavigationLink(
                        destination: {TabbedView(contact: contact).onAppear{listViewModel.updateCurrentContact(contact: contact)}},
                        label: {RowView(contact: contact)})
                }
                .onDelete(perform: listViewModel.deleteContact)
            }
            .navigationTitle("Contacts")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink("Add", destination: AddContactView(newFirst: "", newLast: "", newAddress: "", newCity: "", newState: "", newZip: "", newPhone: "", newEmail: ""))
                }
            }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ListView()
                .environmentObject(ListViewModel())
        }
    }
}
