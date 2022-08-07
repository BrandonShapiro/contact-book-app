//
//  ContactBookApp.swift
//  Contact Book
//
//  Created by Brandon Shapiro on 8/6/22.
//

import SwiftUI

@main
struct Contact_BookApp: App {

    @StateObject var listViewModel : ListViewModel = ListViewModel()
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            NavigationView{
                ListView()
            }
            .environmentObject(listViewModel)
        }
        .onChange(of: scenePhase){ newPhase in
            if newPhase == .active {
                InventoryCache.sharedCache.readDatabase(contacts: &listViewModel.contactList)
            } else if newPhase == .inactive {
                InventoryCache.sharedCache.writeDatabase(contacts: &listViewModel.contactList)
            }
        }
    }
}
