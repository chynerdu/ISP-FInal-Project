//
//  ContactsTableViewController.swift
//  ContactsApp
//
//  Created by Sreenath Segar on 2023-08-04.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    var contactList:ContactList!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        contactList = ContactList()
        contactList.fetch()
        tableView.delegate = self
        tableView.dataSource = self
        // Sort the contacts array based on first name in alphabetical order
        contactList.contacts.sort { $0.firstName.localizedCaseInsensitiveCompare($1.firstName) == .orderedAscending }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contactList.contacts.count

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactList", for: indexPath)
        // Configure the cell...
        let row = indexPath.row
        let contact = contactList.contacts[row]
        let firstName = contact.firstName
        let lastName = contact.lastName
        let phoneNumber = contact.phoneNumber
        let formattedPhoneNumber = formatPhoneNumber(phoneNumber: phoneNumber)
        let contactDetails = "\(firstName) \(lastName)\n\(formattedPhoneNumber)"
        cell.textLabel?.text = contactDetails
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    // Function to format the phone number as (123) 456-7890
     private func formatPhoneNumber(phoneNumber: Int) -> String {
        let phoneNumberString = String(phoneNumber)
        let areaCode = phoneNumberString.prefix(3)
        let firstThreeDigits = phoneNumberString.dropFirst(3).prefix(3)
        let lastFourDigits = phoneNumberString.dropFirst(6).prefix(4)
        return "(\(areaCode)) \(firstThreeDigits)-\(lastFourDigits)"
        }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            contactList.deleteContact(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let contact = contactList.contacts[indexPath.row]
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let contactDetailsVC = storyboard.instantiateViewController(withIdentifier: "ContactInformationViewController") as! ContactInformationViewController
//        contactDetailsVC.contact = contact
//        navigationController?.pushViewController(contactDetailsVC, animated: true)
//    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             // Get the new view controller using segue.destination.
             // Pass the selected object to the new view controller.
             if let dst = segue.destination as? ContactInformationViewController {
                 dst.contactList = contactList
                 dst.tableView = tableView
                 
                 if segue.identifier == "ContactInformationViewController" {
                     if let indexPath = tableView.indexPathForSelectedRow {
                         let row = indexPath.row
                         dst.contact = contactList.contacts[row]
                         dst.indexPath = indexPath
                     }
                 }
             }
         }

}
