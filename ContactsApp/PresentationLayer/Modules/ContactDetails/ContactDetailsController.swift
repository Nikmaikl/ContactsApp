//
//  ContactDetailsController.swift
//  ContactsApp
//
//  Created by Michael Nikolaev on 06.01.2018.
//  Copyright © 2018 Michael Nikolaev. All rights reserved.
//

import UIKit

class ContactDetailsController: UITableViewController {
    
    var cellPlaceholders = [String]()
    
    var contact: Contact! {
        didSet {
            self.title = contact.firstName + " " + contact.lastName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.largeTitleDisplayMode = .never
        self.tableView.register(UINib.init(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: "DetailCell")
        configPlaceholders()
    }
    
    func configPlaceholders() {
        cellPlaceholders.append("First Name")
        cellPlaceholders.append("Last Name")
        cellPlaceholders.append("Phone Number")
        cellPlaceholders.append("Street Address1")
        cellPlaceholders.append("Street Address2")
        cellPlaceholders.append("City")
        cellPlaceholders.append("State")
        cellPlaceholders.append("ZipCode")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellPlaceholders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "DetailCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! DetailCell
        cell.placeholderTextField.placeholder = cellPlaceholders[indexPath.row]
        
        return cell
    }
}
