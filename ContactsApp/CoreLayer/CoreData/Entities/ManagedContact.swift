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
    private static func generateContactIdString() -> String {
        return String("\(arc4random()) \(arc4random())")
    }
    
    static func findContacts(in context: NSManagedObjectContext) -> [ManagedContact]? {
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print("Model is not availible in context!")
            assert(false)
            return nil
        }
        
        guard let fetchRequest = ManagedContact.fetchRequestContacts(model: model) else {
            return nil
        }

        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            print("Failed to fetch AppUSer: \(error)")
        }

        return nil
    }
    
    static func findContact(with id: String, context: NSManagedObjectContext) -> ManagedContact? {
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print("Model is not availible in context!")
            assert(false)
            return nil
        }
        
        guard let fetchRequest = ManagedContact.fetchRequestContactById(model: model, substitutionVariables: ["contactID": id]) else {
            return nil
        }
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count == 0 {
                return nil
            }
            return results[0]
        } catch {
            print("Failed to fetch AppUSer: \(error)")
        }
        
        return nil
    }
    
    static func deleteContact(with id: String) {
        if let context = CoreDataManager.coreDataStack?.saveContext {
            if let contact = findContact(with: id, context: context) {
                context.delete(contact)
                
                CoreDataManager.save()
            }
        }
    }
    
    static func updateContact(updatedContact: Contact) {
        if let context = CoreDataManager.coreDataStack?.saveContext {
            if let contact = findContact(with: updatedContact.contactID, context: context) {
                contact.firstName = updatedContact.firstName
                contact.lastName = updatedContact.lastName
                contact.phoneNumber = updatedContact.phoneNumber
                contact.streetAddress1 = updatedContact.streetAddress1
                contact.streetAddress2 = updatedContact.streetAddress2
                contact.city = updatedContact.city
                contact.state = updatedContact.state
                contact.zipCode = updatedContact.zipCode
                
                CoreDataManager.save()
            }
        }
    }
    
    private static func fetchRequestContactById(model: NSManagedObjectModel, substitutionVariables: [String:String]) -> NSFetchRequest<ManagedContact>? {
        let templateName = "ManagedContactById"
        
        guard let fetchRequest = model.fetchRequestFromTemplate(withName: templateName, substitutionVariables: substitutionVariables) as? NSFetchRequest<ManagedContact> else {
            assert(false, "No template with name \(templateName)!")
            return nil
        }
        
        return fetchRequest.copy() as? NSFetchRequest<ManagedContact>
    }
    
    private static func fetchRequestContacts(model: NSManagedObjectModel) -> NSFetchRequest<ManagedContact>? {
        let templateName = "ManagedContact"
        
        guard let fetchRequest = model.fetchRequestFromTemplate(withName: templateName, substitutionVariables: [:]) as? NSFetchRequest<ManagedContact> else {
            assert(false, "No template with name \(templateName)!")
            return nil
        }
        
        return fetchRequest.copy() as? NSFetchRequest<ManagedContact>
    }
    
    static func addContact(newContact: Contact) {
        guard let context = CoreDataManager.coreDataStack?.saveContext else {
            print("Unable to get context")
            return
        }
        
        let contact = NSEntityDescription.insertNewObject(forEntityName: "ManagedContact", into: context) as? ManagedContact
        contact?.contactID = ManagedContact.generateContactIdString()
        contact?.firstName = newContact.firstName
        contact?.lastName = newContact.lastName
        contact?.phoneNumber = newContact.phoneNumber
        contact?.streetAddress1 = newContact.streetAddress1
        contact?.streetAddress2 = newContact.streetAddress2
        contact?.city = newContact.city
        contact?.state = newContact.state
        contact?.zipCode = newContact.zipCode
        
        CoreDataManager.save()
    }
}

