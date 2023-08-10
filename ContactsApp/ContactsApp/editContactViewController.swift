//
//  editContactViewController.swift
//  ContactsApp
//
//  Created by Sreenath Segar on 2023-08-10.
//

import UIKit
protocol EditContactDelegate: AnyObject {
    func didUpdateContact(_ contact: Contact)
}

class editContactViewController: UIViewController {
    var contact: Contact?
    var contactList: ContactList?
    weak var delegate: EditContactDelegate?
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBAction func saveButton(_ sender: UIButton) {
        guard
            let firstName = firstName.text, !firstName.isEmpty,
            let lastName = lastName.text, !lastName.isEmpty,
            let phoneNumberStr = phoneNumber.text, let _ = Int(phoneNumberStr)
        else {
            return
        }
        let numericString = String(phoneNumberStr.filter { $0.isNumber })
        if numericString.count != 10 {
            showAlert(message: "Phone number should have exactly 10 digits.")
            return
        }
        // Update the contact's information
        if let contactToUpdate = contact {
            contactToUpdate.firstName = firstName
            contactToUpdate.lastName = lastName
            contactToUpdate.phoneNumber = Int(phoneNumberStr) ?? 0
            delegate?.didUpdateContact(contactToUpdate)
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let contact = contact {
                    firstName.text = contact.firstName
                    lastName.text = contact.lastName
                    phoneNumber.text = "\(contact.phoneNumber)"
                }
        
    }
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Invalid Phone Number", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
   


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
