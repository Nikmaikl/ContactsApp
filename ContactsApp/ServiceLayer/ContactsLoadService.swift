//
//  ContactsLoadService.swift
//  ContactsApp
//
//  Created by Michael Nikolaev on 06.01.2018.
//  Copyright © 2018 Michael Nikolaev. All rights reserved.
//

import Foundation

class ContactsLoadService {
    private let parser = ContactParser()
    
    func configureContacts() -> [Contact]? {
        var finalContacts: [Contact]?
        
        if let context = CoreDataManager.coreDataStack?.saveContext {
            if let contacts = ManagedContact.findContacts(in: context) {
                
                if contacts.count == 0 {
                    if let contacts = loadContacts() {
                        finalContacts = contacts
                        for contact in contacts {
                            ManagedContact.addContact(firstName: contact.firstName, lastName: contact.lastName, phoneNumber: contact.phoneNumber, streetAddress1: contact.streetAddress1, streetAddress2: contact.streetAddress2, city: contact.city, state: contact.state, zipCode: contact.zipCode)
                        }
                        return finalContacts
                    }
                } else {
                    finalContacts = [Contact]()
                    for contact in contacts {
                        finalContacts!.append(Contact(contactID: contact.contactID!, firstName: contact.firstName!, lastName: contact.lastName!, phoneNumber: contact.phoneNumber!, streetAddress1: contact.streetAddress1, streetAddress2: contact.streetAddress2, city: contact.city, state: contact.state, zipCode: contact.zipCode))
                    }
                }
            }
        }
        
        return finalContacts
    }
    
    private func loadContacts() -> [Contact]? {
        guard let path = Bundle.main.path(forResource: "contacts", ofType: "json") else { return nil }
        
        do {
            let data = try Data.init(contentsOf: URL(string: "file://"+path)!, options: [])
            return parser.parse(data: data)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}