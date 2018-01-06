//
//  Contact.swift
//  ContactsApp
//
//  Created by Michael Nikolaev on 05.01.2018.
//  Copyright © 2018 Michael Nikolaev. All rights reserved.
//

import Foundation
import CoreData

extension ManagedContact {
    static func generateContactIdString() -> String {
        return String(arc4random()+arc4random())
    }
    
    static func fetchRequestContacts(with: String, model: NSManagedObjectModel) -> NSFetchRequest<ManagedContact>? {
        let templateName = "ManagedContact"
        
        guard let fetchRequest = model.fetchRequestFromTemplate(withName: templateName, substitutionVariables: ["id" : with]) as? NSFetchRequest<ManagedContact> else {
            assert(false, "No template with name \(templateName)!")
            return nil
        }
        
        return fetchRequest.copy() as? NSFetchRequest<ManagedContact>
    }
    
    static func addContact(with contactID: String, firstName: String, lastName:  String, phoneNumber: String, streetAddress1: String, streetAddress2: String, city: String, state: String, zipCode: String) {
        guard let context = CoreDataManager.coreDataStack?.saveContext else {
            print("Unable to get context")
            return
        }
        
        let contact = NSEntityDescription.insertNewObject(forEntityName: "ManagedContact", into: context) as? ManagedContact
        contact?.contactID = contactID
        contact?.firstName = firstName
        contact?.lastName = lastName
        contact?.phoneNumber = phoneNumber
        contact?.streetAddress1 = streetAddress1
        contact?.streetAddress2 = streetAddress2
        contact?.city = city
        contact?.state = state
        contact?.zipCode = zipCode
        
        CoreDataManager.save()
    }
}

