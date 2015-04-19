//
//  DetailViewController.swift
//  ContactViewer
//
//  Created by Kevin Pichelman on 4/11/15.
//  Copyright (c) 2015 Highly Clever Software LLC. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var titleTF: UITextField!    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var twitterIdTF: UITextField!
    @IBOutlet weak var editValuesBtn: UIButton!
    
    var _editMode = false
    var contact: Contact = Contact(name: "", phone: "", title: "", email: "", twitterId: "")
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            contact = detail as! Contact
            
            if let name = self.nameTF {
                name.text = contact.name
            }
            
            if let phone = self.phoneTF {
                phone.text = contact.phone
            }
            
            if let title = self.titleTF {
                title.text = contact.title
            }
            
            if let email = self.emailTF {
                email.text = contact.email
            }
            
            if let twitterId = self.twitterIdTF {
                twitterId.text = contact.twitterId
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        self.setupEditMode(false)
        self.configureSaveButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureSaveButton() {
        let buttonTitle = NSLocalizedString("Edit", comment: "")
        editValuesBtn.setTitle(buttonTitle, forState: .Normal)
        editValuesBtn.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
    }
    
    func buttonClicked(sender: UIButton) {
        NSLog("A button was clicked: \(sender).")
        if (_editMode) {
            showOkayCancelAlert()
        } else {
            _editMode = true
            setupEditMode(_editMode)
        }
    }
    
    func setupEditMode(editMode: Bool) {
        
        if editMode {
            editValuesBtn.setTitle("Save", forState: UIControlState.Normal)
            self.nameTF.enabled = true
            self.phoneTF.enabled = true
            self.titleTF.enabled = true
            self.emailTF.enabled = true
            self.twitterIdTF.enabled = true
            
        } else {
            editValuesBtn.setTitle("Edit", forState: UIControlState.Normal)
            self.nameTF.enabled = false
            self.phoneTF.enabled = false
            self.titleTF.enabled = false
            self.emailTF.enabled = false
            self.twitterIdTF.enabled = false
        }
    }
    
    func saveUpdateContact() {
    
    }
    
    /// Show an alert with an "Save" and "Cancel" button.
    func showOkayCancelAlert() {
        let title = NSLocalizedString("Save Contact", comment: "")
        let message = NSLocalizedString("Save your Contact?", comment: "")
        let cancelButtonTitle = NSLocalizedString("Cancel", comment: "")
        let otherButtonTitle = NSLocalizedString("Save", comment: "")
        
        let alertCotroller = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        // Create the actions.
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .Cancel) { action in
            NSLog("The \"Okay/Cancel\" alert's cancel action occured.")
            self.configureView()
        }
        
        let otherAction = UIAlertAction(title: otherButtonTitle, style: .Default) { action in
            NSLog("The \"Okay/Cancel\" alert's other action occured.")
            var dbHelper = DBHelper()
            dbHelper.addUpdateContact(self.contact)
            self._editMode = false
            self.setupEditMode(self._editMode)
        }
        
        // Add the actions.
        alertCotroller.addAction(cancelAction)
        alertCotroller.addAction(otherAction)
        
        presentViewController(alertCotroller, animated: true, completion: nil)
    }


}

