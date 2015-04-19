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
    var _unsaveData = false
    var contact: Contact = Contact(name: "", phone: "", title: "", email: "", twitterId: "", newContact: true)
    
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
        if self.contact.newContact {
            self._editMode = true;
        }
        
        self.configureView()
        self.configureSaveButton()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.setupEditMode(self._editMode)
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
        if (_editMode) {
           // Removed alert, its not really needed
           // showOkayCancelAlert()
            _editMode = false
            self._unsaveData = false
            self.contact.newContact = false;
            self.contact.name = self.nameTF.text
            self.contact.phone = self.phoneTF.text
            self.contact.email = self.emailTF.text
            self.contact.title = self.titleTF.text
            self.contact.twitterId = self.twitterIdTF.text
            var dbHelper = DBHelper()
            dbHelper.addUpdateContact(self.contact)
            self.setupEditMode(self._editMode)
            
        } else {
            _unsaveData = true
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
            _unsaveData = true
            
        } else {
            editValuesBtn.setTitle("Edit", forState: UIControlState.Normal)
            self.nameTF.enabled = false
            self.phoneTF.enabled = false
            self.titleTF.enabled = false
            self.emailTF.enabled = false
            self.twitterIdTF.enabled = false
        }
    }
}

