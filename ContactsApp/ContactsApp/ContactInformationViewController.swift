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

           if let contact = contact {
               fullName.text = "\(contact.firstName) \(contact.lastName)"
               phoneNumber.text = formatPhoneNumber(phoneNumber: contact.phoneNumber)
           }
       }
        func formatPhoneNumber(phoneNumber: Int) -> String {
                let phoneNumberString = String(phoneNumber)
                let areaCode = phoneNumberString.prefix(3)
                let firstThreeDigits = phoneNumberString.dropFirst(3).prefix(3)
                let lastFourDigits = phoneNumberString.dropFirst(6).prefix(4)
                return "(\(areaCode)) \(firstThreeDigits)-\(lastFourDigits)"
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
