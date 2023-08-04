//
//  ViewController.swift
//  ContactsApp
//
//  Created by Sreenath Segar on 2023-07-14.
//

import UIKit

class ViewController: UIViewController {
    var contact: Contact?
    var indexPath: IndexPath?
    var tableView: UITableView!
    var contactList: ContactList!

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactList = ContactList()
        tableView = UITableView()
    }

    @IBAction func submitButton(_ sender: Any) {
        guard
            let firstName = firstName.text, !firstName.isEmpty,
            let lastName = lastName.text, !lastName.isEmpty,
            let phoneNumberStr = phoneNumber.text, let phoneNumber = Int(phoneNumberStr)
        else {
            return
        }
        
        
        let contact = Contact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
            contactList.contacts.insert(contact, at: 0)
            contactList.saveContacts()
        // Sort the contacts array based on first name in alphabetical order
            contactList.contacts.sort { $0.firstName.localizedCaseInsensitiveCompare($1.firstName) == .orderedAscending }
        if let contactsTableViewController = navigationController?.viewControllers.first as? ContactsTableViewController {
                    contactsTableViewController.contactList = contactList
                    contactsTableViewController.tableView.reloadData()
                }
            navigationController?.popViewController(animated: true)
    }
    
}
