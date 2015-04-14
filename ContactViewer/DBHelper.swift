//
//  DBHelper.swift
//  ContactViewer
//
//  Created by Kevin Pichelman on 4/12/15.
//  Copyright (c) 2015 Highly Clever Software LLC. All rights reserved.
//

import Foundation

class DBHelper {
    
    func aMethod() {
        
        let documentsFolder:String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let path = documentsFolder.stringByAppendingPathComponent("test.sqlite")
        
        let database = FMDatabase(path: path)
        
        if (!database.open()) {
            println("Unable to open database")
            return
        }
        
        if !database.executeUpdate("create table test(x text, y text, z text)", withArgumentsInArray: nil) {
            println("create table failed: \(database.lastErrorMessage())")
        }
        
        if !database.executeUpdate("insert into test (x, y, z) values (?, ?, ?)", withArgumentsInArray: ["a", "b", "c"]) {
            println("insert 1 table failed: \(database.lastErrorMessage())")
        }
        
        if !database.executeUpdate("insert into test (x, y, z) values (?, ?, ?)", withArgumentsInArray: ["e", "f", "g"]) {
            println("insert 2 table failed: \(database.lastErrorMessage())")
        }
        
        let rs = database.executeQuery("select x, y, z from test", withArgumentsInArray: nil)
        if (rs != nil) {
            while rs.next() {
                let x = rs.stringForColumn("x")
                let y = rs.stringForColumn("y")
                let z = rs.stringForColumn("z")
                println("x = \(x); y = \(y); z = \(z)")
            }
        } else {
            println("select failed: \(database.lastErrorMessage())")
        }
        
        database.close()
    }
}