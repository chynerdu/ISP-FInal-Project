//
//  Contact.swift
//  ContactsApp
//
//  Created by Sreenath Segar on 2023-08-04.
//

import Foundation

class Contact: NSObject, NSCoding, NSSecureCoding {
    static var supportsSecureCoding: Bool = true
    
    var firstName: String
    var lastName: String
    var phoneNumber: Int
    
    init(firstName: String, lastName: String, phoneNumber: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(firstName, forKey: "firstName")
        coder.encode(lastName, forKey: "lastName")
        coder.encode(phoneNumber, forKey: "phoneNumber")
    }
    
    required init?(coder: NSCoder) {
        firstName = coder.decodeObject(forKey: "firstName") as! String
        lastName = coder.decodeObject(forKey: "lastName") as! String
        phoneNumber = coder.decodeInteger(forKey: "phoneNumber")
    }
}

