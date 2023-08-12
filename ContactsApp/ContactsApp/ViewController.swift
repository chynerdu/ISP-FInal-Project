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
    //    Submit button functionality
    @IBAction func submitButton(_ sender: Any) {
        guard
            let firstName = firstName.text, !firstName.isEmpty,
            let lastName = lastName.text, !lastName.isEmpty,
            let phoneNumberStr = phoneNumber.text, let phoneNumber = Int(phoneNumberStr)
        else {
            showAlert(title: "Missing Information", message: "All input fields are required.")
            return
        }
        // Perform the phone number validation
        let numericString = String(phoneNumberStr.filter { $0.isNumber })
        if numericString.count != 10 {
            showAlert(title: "Invalid Phone Number", message: "Phone number should have exactly 10 digits.")
            return
        }
        //    save contact
        let contact = Contact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        contactList.contacts.insert(contact, at: 0)
        contactList.saveContacts()
        // Sort the contacts array based on first name in alphabetical order
        contactList.contacts.sort { $0.firstName.localizedCaseInsensitiveCompare($1.firstName) == .orderedAscending }
        if let contactsTableViewController = navigationController?.viewControllers.first as? ContactsTableViewController {
            contactsTableViewController.contactList = contactList
            contactsTableViewController.tableView.reloadData()
        }
        showAlertWithDelayedNavigation(title: "Success", message: "Contact saved successfully.")
        
    }
    // Function to show an alert with a given message
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    private func showAlertWithDelayedNavigation(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alertController, animated: true, completion: nil)
        
        // Dismiss the alert after 2 seconds and navigate back
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            alertController.dismiss(animated: true) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
