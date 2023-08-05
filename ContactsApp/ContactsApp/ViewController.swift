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
        navigationController?.navigationBar.tintColor = UIColor.systemGreen
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
        // Perform the phone number validation
                let numericString = String(phoneNumberStr.filter { $0.isNumber })
                if numericString.count != 10 {
                    showAlert(message: "Phone number should have exactly 10 digits.")
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
    // Function to show an alert with a given message
       private func showAlert(message: String) {
           let alertController = UIAlertController(title: "Invalid Phone Number", message: message, preferredStyle: .alert)
           let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alertController.addAction(okAction)
           present(alertController, animated: true, completion: nil)
       }

    
}
