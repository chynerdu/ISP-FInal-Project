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
        // Create a new Contact with the provided data
           let contact = Contact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
            contactList.contacts.insert(contact, at: 0)
        let indexPath = IndexPath(row: contactList.contacts.count - 1, section: 0)
        navigationController?.popViewController(animated: true)
         tableView.insertRows(at: [indexPath], with: .automatic)
         tableView.reloadData()

        // Save the updated contacts and reload the table view
            contactList.saveContacts()
            tableView.reloadData()
       
    }
    
}
