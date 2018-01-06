//
//  ContactDetailsController.swift
//  ContactsApp
//
//  Created by Michael Nikolaev on 06.01.2018.
//  Copyright © 2018 Michael Nikolaev. All rights reserved.
//

import UIKit

class ContactDetailsController: UITableViewController {
    
    var contact: Contact! {
        didSet {
            self.title = contact.firstName + " " + contact.lastName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "ContactCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ContactCell
        cell.nameLbl.text = contact.firstName + " " + contact.lastName
        
        return cell
    }
}
