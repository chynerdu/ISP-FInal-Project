//
//  ContactInformationViewController.swift
//  ContactsApp
//
//  Created by Sreenath Segar on 2023-08-04.
//

import UIKit

class ContactInformationViewController: UIViewController {
    var contact: Contact?
    var indexPath: IndexPath?
    var tableView: UITableView!
    var contactList: ContactList!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.systemGreen
        if let contact = contact {
            fullName.text = "\(contact.firstName) \(contact.lastName)"
            phoneNumber.text = formatPhoneNumber(phoneNumber: contact.phoneNumber)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(contactUpdated(_:)), name: Notification.Name("ContactUpdated"), object: nil)
        
    }
    //format the number in phone number format
    func formatPhoneNumber(phoneNumber: Int) -> String {
        let phoneNumberString = String(phoneNumber)
        let areaCode = phoneNumberString.prefix(3)
        let firstThreeDigits = phoneNumberString.dropFirst(3).prefix(3)
        let lastFourDigits = phoneNumberString.dropFirst(6).prefix(4)
        return "(\(areaCode)) \(firstThreeDigits)-\(lastFourDigits)"
    }
    //delete contact button function
    @IBAction func deleteContact(_ sender: UIButton) {
        guard let contact = contact, let indexPath = indexPath else {
            // Invalid data, handle the error or return if needed.
            return
        }
        
        // Show a confirmation dialog box
        let alertController = UIAlertController(
            title: "Delete Contact",
            message: "Are you sure you want to delete \(contact.firstName) \(contact.lastName)?",
            preferredStyle: .alert
        )
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { _ in
            // Remove the contact from the table view
            self.contactList.contacts.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.contactList.saveContacts()
            self.navigationController?.popViewController(animated: true)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func contactUpdated(_ notification: Notification) {
        if let updatedContact = notification.object as? Contact, updatedContact === contact {
            // Update the view with the updated contact's information
            fullName.text = "\(updatedContact.firstName) \(updatedContact.lastName)"
            phoneNumber.text = formatPhoneNumber(phoneNumber: updatedContact.phoneNumber)
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dst = segue.destination as? editContactViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                dst.contact = contactList.contacts[indexPath.row]
            }
        }
    }
}
