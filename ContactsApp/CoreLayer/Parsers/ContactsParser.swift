//
//  ContactsParser.swift
//  ContactsApp
//
//  Created by Michael Nikolaev on 06.01.2018.
//  Copyright © 2018 Michael Nikolaev. All rights reserved.
//

import Foundation
import CoreData

struct Contact: Decodable {

    let contactID: String
    let firstName: String
    let lastName: String
    let phoneNumber: String?
    let streetAddress1: String?
    let streetAddress2: String?
    let city: String?
    let state: String?
    let zipCode: String?
}

class ContactParser: Parser<[Contact]> {
    override func parse(data: Data) -> [Contact]? {
        do {
            let contacts = try JSONDecoder().decode([Contact].self, from: data)
            print(contacts)
            return contacts
        } catch  {
            print(error.localizedDescription)
            return nil
        }
    }
}
