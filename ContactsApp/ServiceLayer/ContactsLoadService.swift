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
    
    func loadContacts() -> [Contact]? {
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