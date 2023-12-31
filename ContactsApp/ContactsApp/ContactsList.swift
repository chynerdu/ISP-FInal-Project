//
//  ContactList.swift
//  ContactsApp
//
//  Created by Sreenath Segar on 2023-08-04.
//

import Foundation

class ContactList {
    var contacts = [Contact]()
    var taskURL = {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("contact.archive")
    }()
    
    init() {
        fetch()
    }
    //    fetch the contact from the archive
    func fetch() {
        do {
            let archivedData = try Data(contentsOf: taskURL)
            if let unarchivedContacts = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, Contact.self], from: archivedData) as? [Contact] {
                contacts = unarchivedContacts
            }
        } catch {
            print("Error fetching contacts: \(error)")
        }
    }
    //    add the contact to the archive
    func addContact(firstName: String, lastName: String, phoneNumber: Int) {
        let newContact = Contact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        contacts.append(newContact)
        saveContacts()
    }
    //    delete the contact from the archive
    func deleteContact(indexPath: IndexPath){
        let index = indexPath.row
        contacts.remove(at: index)
        saveContacts()
    }
    //    save the contact from the archive
    func saveContacts() {
        do {
            let archivedData = try NSKeyedArchiver.archivedData(withRootObject: contacts, requiringSecureCoding: false)
            try archivedData.write(to: taskURL)
        } catch {
            print("Error saving contacts: \(error)")
        }
    }
}
