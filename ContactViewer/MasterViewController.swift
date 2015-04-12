//
//  MasterViewController.swift
//  ContactViewer
//
//  Created by Kevin Pichelman on 4/11/15.
//  Copyright (c) 2015 Highly Clever Software LLC. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var contacts = [Contact]()


    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
        
        let contact1 = Contact(name: "Kevin", phone: "612-555-3829", title: "Software Engineer", email: "kevin@pichelman.com", twitterId: "kpichelman")
        
        let contact2 = Contact(name: "Billly Bob", phone: "443-555-4322", title: "Unemployeed", email: "bbob@aolonline.com", twitterId: "thereal_billybob")
        
        let contact3 = Contact(name: "Tucan Sam", phone: "221-555-9374", title: "Spokes Person", email: "tsam@generalmills.com", twitterId: "tucan")
    
        contacts.append(contact1);
        contacts.append(contact2);
        contacts.append(contact3);
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
        
       // let docPath = NSSearchPathDirectoryInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
       // let path = NSBundle.mainBundle().pathForResource("filename", ofType: "fileExt")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 ///   func insertNewObject(sender: AnyObject) {
 ///       objects.insert(NSDate(), atIndex: 0)
 ///       let indexPath = NSIndexPath(forRow: 0, inSection: 0)
 ///       self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
 ///   }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                
                let object = contacts[indexPath.row] as Contact
                
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        let object = contacts[indexPath.row] as Contact
        
        cell.textLabel!.text = object.name
        // hack because we don't have a custom cell setup (yet!)
        cell.detailTextLabel!.text = "\(object.phone)  \(object.title)"
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            contacts.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let ctrl = EditViewController(nibName: "EditViewController", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
        
    }
}

