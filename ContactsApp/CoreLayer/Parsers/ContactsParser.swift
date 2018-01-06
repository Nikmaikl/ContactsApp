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
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var streetAddress1: String?
    var streetAddress2: String?
    var city: String?
    var state: String?
    var zipCode: String?
}

class ContactParser: Parser<[Contact]> {
    override func parse(data: Data) -> [Contact]? {
        do {
            let contacts = try JSONDecoder().decode([Contact].self, from: data)
            return contacts
        } catch  {
            print(error.localizedDescription)
            return nil
        }
    }
}
