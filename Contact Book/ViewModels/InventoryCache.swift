//
//  InventoryCache.swift
//  Contact Book
//
//  Created by Brandon Shapiro on 8/6/22.
//


import Foundation
import SQLite3

class InventoryCache: NSObject{
    
    var db: OpaquePointer? = nil
    var dbIsOpen: Bool = false
    var cachePath: String = ""
    static let sharedCache = InventoryCache()
    
    private override init(){
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("ContactBook.sqlite")
        self.cachePath = fileURL.path
    }
    
    func dbOpen() -> Int32 {
        var result = SQLITE_OK
        result = sqlite3_open(self.cachePath, &self.db)
        
        if result == SQLITE_OK{
            self.dbIsOpen = true
        }
        else{
            print("Error opening database")
        }
        return result
    }
    
    func dbClose() -> Int32 {
        var result = SQLITE_OK
        result = sqlite3_close(db)
        
        if result == SQLITE_OK{
            self.dbIsOpen = false
            self.db = nil
        }
        else{
            print("Error closing database")
        }
        return result
    }
    
    func createTable(){
        
        let createTableQuery = "CREATE TABLE IF NOT EXISTS Contacts (Id INTEGER PRIMARY KEY AUTOINCREMENT, first VARCHAR, last VARCHAR, address VARCHAR, city VARCHAR, state VARCHAR, zip VARCHAR, phone VARCHAR, email VARCHAR)"
        if sqlite3_exec(self.db, createTableQuery, nil, nil, nil) != SQLITE_OK {
            print("Error creating table")
        }
    }
    

    func readDatabase(contacts: inout[ContactModel]){
        //delete any items already in items array
        contacts.removeAll()
        //open the database
        if self.dbIsOpen == false{
            _ = dbOpen()
        }
        //create the table
        createTable()
        //populate the table
        //1 - prepare the sql statement
        var stmt: OpaquePointer? = nil
        let selectQuery = "SELECT Id, first, last, address, city, state, zip, phone, email FROM Contacts ORDER BY Id ASC"
        var result = sqlite3_prepare_v2(self.db, selectQuery, -1, &stmt, nil)
        //if statement runs, iterate through rows
        if result == SQLITE_OK{
            //get next row
            result = sqlite3_step(stmt)
            //keep looping until it reaches SQLITE_DONE
            while result == SQLITE_ROW {
                //get raw values
                let id:Int64 = sqlite3_column_int64(stmt, 0)
                if let rawFirst = sqlite3_column_text(stmt, 1),
                    let rawLast = sqlite3_column_text(stmt, 2),
                    let rawAddress = sqlite3_column_text(stmt, 3),
                    let rawCity = sqlite3_column_text(stmt, 4),
                    let rawState = sqlite3_column_text(stmt, 5),
                    let rawZip = sqlite3_column_text(stmt, 6),
                    let rawPhone = sqlite3_column_text(stmt, 7),
                    let rawEmail = sqlite3_column_text(stmt, 8){
                    //convert to String values
                    let idString = String(id)
                    let first = String(cString: rawFirst)
                    let last = String(cString: rawLast)
                    let address = String(cString: rawAddress)
                    let city = String(cString: rawCity)
                    let state = String(cString: rawState)
                    let zip = String(cString: rawZip)
                    let phone = String(cString: rawPhone)
                    let email = String(cString: rawEmail)
                    //create new Item and append to list
                    let newContact: ContactModel = ContactModel(id: idString, first: first, last: last, address: address, city: city, state: state, zip: zip, phone: phone, email: email)
                    contacts.append(newContact)
                }//end if let
                result = sqlite3_step(stmt)
            }//end while
        }//end if result
        //finalize statement and close database
        sqlite3_finalize(stmt)
        _ = dbClose()
        if(contacts.isEmpty){
            //make sure list isn't completely empty
            contacts.append(ContactModel(first: "Weber", last: "State", address: "3848 Harrison Blvd", city: "Ogden", state: "UT", zip: "84408", phone: "1234567890", email: "webermail@mail.weber.edu"))
        }
    }//end readDatabase
    
    
    func writeDatabase(contacts: inout [ContactModel]) {
        //open the database
        if self.dbIsOpen == false{
            _ = dbOpen()
        }
        //delete all items from table before writing
        let deleteQuery = "DELETE FROM Contacts"
        if sqlite3_exec(self.db, deleteQuery, nil, nil, nil) != SQLITE_OK{
            print("Error deleting table")
        }
        //for each item in array, insert into database
        for contact in contacts{
            //create the sql statement
            var stmt: OpaquePointer? = nil
            let insertQuery = "INSERT INTO Contacts (first, last, address, city, state, zip, phone, email) VALUES (?,?,?,?,?,?,?,?)"
            //prepare the sql statement
            if sqlite3_prepare(self.db, insertQuery, -1, &stmt, nil) != SQLITE_OK{
                print("Error binding insert query")
            }
            //bind the values to the sql statement
            if sqlite3_bind_text(stmt, 1, (contact.first as NSString).utf8String, -1, nil) != SQLITE_OK{
                print("Error binding first")
            }
            if sqlite3_bind_text(stmt, 2, (contact.last as NSString).utf8String, -1, nil) != SQLITE_OK{
                print("Error binding last")
            }
            if sqlite3_bind_text(stmt, 3, (contact.address as NSString).utf8String, -1, nil) != SQLITE_OK{
                print("Error binding address")
            }
            if sqlite3_bind_text(stmt, 4, (contact.city as NSString).utf8String, -1, nil) != SQLITE_OK{
                print("Error binding city")
            }
            if sqlite3_bind_text(stmt, 5, (contact.state as NSString).utf8String, -1, nil) != SQLITE_OK{
                print("Error binding state")
            }
            if sqlite3_bind_text(stmt, 6, (contact.zip as NSString).utf8String, -1, nil) != SQLITE_OK{
                print("Error binding zipcode")
            }
            if sqlite3_bind_text(stmt, 7, (contact.phone as NSString).utf8String, -1, nil) != SQLITE_OK{
                print("Error binding phone")
            }
            if sqlite3_bind_text(stmt, 8, (contact.email as NSString).utf8String, -1, nil) != SQLITE_OK{
                print("Error binding email")
            }
            //execute the prepared sql statement
            if sqlite3_step(stmt) != SQLITE_DONE{
                print("Error inserting item")
            }
            //finalize all statements before closing
            if sqlite3_finalize(stmt) != SQLITE_OK{
                print("Error deleting statement")
            }
        }//end forEach
        //close database after writing to it
        _ = dbClose()
    }//end writeDatabase

}//end InventoryCache class
