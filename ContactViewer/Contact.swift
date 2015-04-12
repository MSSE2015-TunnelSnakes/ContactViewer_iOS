//
//  Contact.swift
//  ContactViewer
//
//  Created by Kevin Pichelman on 4/11/15.
//  Copyright (c) 2015 Highly Clever Software LLC. All rights reserved.
//

import Foundation

class Contact: NSObject {
    
    var name:String
    var phone:String
    var title:String
    var email:String
    var twitterId:String
    
    init(name:String, phone:String, title:String, email:String, twitterId:String) {
        self.name = name;
        self.phone = phone;
        self.email = email;
        self.title = title;
        self.twitterId = twitterId;
    }
}