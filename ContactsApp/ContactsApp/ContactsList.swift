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

    func fetch() {
        do {
            let archivedData = try Data(contentsOf: taskURL)
            contacts = try NSKeyedUnarchiver.unarchivedArrayOfObjects(ofClass: Contact.self, from: archivedData) ?? [Contact]()
        } catch {
            print("Error: \(error)")
        }
    }

    func addContact(firstName: String, lastName: String, phoneNumber: Int) {
        let newContact = Contact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        contacts.append(newContact)
        saveContacts()
    }

    func saveContacts() {
        do {
            let archivedData = try NSKeyedArchiver.archivedData(withRootObject: contacts, requiringSecureCoding: false)
            try archivedData.write(to: taskURL)
        } catch {
            print("Error: \(error)")
        }
    }
}
