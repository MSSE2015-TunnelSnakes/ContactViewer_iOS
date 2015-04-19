//
//  Contact.swift
//  ContactViewer
//
//  Created by Kevin Pichelman on 4/11/15.
//  Copyright (c) 2015 Highly Clever Software LLC. All rights reserved.
//

import Foundation

class Contact: NSObject {
    
    var id:Int32
    var name:String
    var phone:String
    var title:String
    var email:String
    var twitterId:String
    var newContact:Bool // TODO: Remove
    
    init(name:String, phone:String, title:String, email:String, twitterId:String, newContact:Bool) {
        self.id = 0
        self.name = name
        self.phone = phone
        self.email = email
        self.title = title
        self.twitterId = twitterId
        self.newContact = newContact
    }
    
    func updateId(id:Int32) {
        self.id = id;
    }
}