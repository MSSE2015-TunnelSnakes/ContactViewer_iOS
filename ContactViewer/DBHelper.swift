//
//  DBHelper.swift
//  ContactViewer
//
//  Created by Kevin Pichelman on 4/12/15.
//  Copyright (c) 2015 Highly Clever Software LLC. All rights reserved.
//

import Foundation

class DBHelper {
    func setupDatabase() {
        // NOTE: KEV - It seems wrong that we always calculate folder locations, open, then close the db...
        let documentsFolder:String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let path = documentsFolder.stringByAppendingPathComponent("ContactViewer.sqlite")
        
        let database = FMDatabase(path: path)
        
        if (!database.open()) {
            println("Unable to open database")
            return
        }
        
        database.executeStatements("CREATE TABLE IF NOT EXISTS Contacts (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phone TEXT, title TEXT, email TEXT, twitterId TEXT);")
        
        // If we are filling with dummy data do the following
        
        let contact1 = Contact(name: "Kevin", phone: "612-555-3829", title: "Software Engineer", email: "kevin@pichelman.com", twitterId: "kpichelman")
        
        let contact2 = Contact(name: "Billly Bob", phone: "443-555-4322", title: "Unemployeed", email: "bbob@aolonline.com", twitterId: "thereal_billybob")
        
        let contact3 = Contact(name: "Tucan Sam", phone: "221-555-9374", title: "Spokes Person", email: "tsam@generalmills.com", twitterId: "tucan")
        
        
        addUpdateContact(contact1)
        addUpdateContact(contact2)
        addUpdateContact(contact3)
        // End dummy data
        
        database.close()
    }
    
    func addUpdateContact(contact: Contact) {
        let documentsFolder:String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let path = documentsFolder.stringByAppendingPathComponent("ContactViewer.sqlite")
        
        let database = FMDatabase(path: path)
        
        if (!database.open()) {
            println("Unable to open database")
            return
        }
        
        if (contact.id <= 0) {
            database.executeStatements("INSERT INTO Contacts (name, phone, title, email, twitterId) VALUES ( '\(contact.name)', '\(contact.phone)', '\(contact.title)', '\(contact.email)', '\(contact.twitterId)' );")
        } else {
            var rs = database.executeQuery("SELECT * FROM Contacts WHERE id = \(contact.id)", withArgumentsInArray: nil)
            if (rs != nil && !rs.next()) { // if you are not nil and don't contain any records, you are a new value
            
                database.executeStatements("INSERT INTO Contacts (id, name, phone, title, email, twitterId) VALUES ('\(contact.id)', '\(contact.name)', '\(contact.phone)', '\(contact.title)', '\(contact.email)', '\(contact.twitterId)' );")
            } else {
                database.executeStatements("UPDATE Contacts SET name = '\(contact.name)', phone = '\(contact.phone)', title = '\(contact.title)', email = '\(contact.email)', twitterId = '\(contact.twitterId)' WHERE id = \(contact.id)")
            }
        }

    }
    
    func getContacts() -> [Contact] {
        var contacts = [Contact]()
        let documentsFolder:String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let path = documentsFolder.stringByAppendingPathComponent("ContactViewer.sqlite")
        let database = FMDatabase(path: path)
        
        if (!database.open()) {
            println("Unable to open database")
            return contacts
        }
        
        let rs = database.executeQuery("SELECT * FROM Contacts", withArgumentsInArray: nil)
        if (rs != nil) {
            while rs.next() {
                let id = rs.intForColumn("id")
                let name = rs.stringForColumn("name")
                let phone = rs.stringForColumn("phone")
                let title = rs.stringForColumn("title")
                let email = rs.stringForColumn("email")
                let twitterId = rs.stringForColumn("twitterId")
                
                var contact = Contact(name: name, phone: phone, title: title, email: email, twitterId: twitterId)
                
                contact.updateId(id)
                
                contacts.append(contact)
            }
        } else {
            println("select failed: \(database.lastErrorMessage())")
        }
        
        database.close()
        
        
        return contacts;
    }
    
    // TODO: Test
    // We are lazy... and not in a good way
    func getContact(customerId: Int32) -> Contact? {
        for contact in getContacts() {
            if contact.id == customerId {
                return contact
            }
        }
        return nil
    }
    
    
    func deleteContact(customerId: Int32) -> Bool {
        let documentsFolder:String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let path = documentsFolder.stringByAppendingPathComponent("ContactViewer.sqlite")
        let database = FMDatabase(path: path)
    
        if (!database.open()) {
            println("Unable to open database")
            return false
        }
        
        return database.executeStatements("DELETE FROM Contacts WHERE id = \(customerId)")
    }
}
