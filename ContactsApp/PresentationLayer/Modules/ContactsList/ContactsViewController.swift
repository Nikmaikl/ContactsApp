//
//  ContactsViewController.swift
//  ContactsApp
//
//  Created by Michael Nikolaev on 05.01.2018.
//  Copyright © 2018 Michael Nikolaev. All rights reserved.
//

import UIKit

class ContactsViewController: UITableViewController {
    
    var contactsLoadService = ContactsLoadService()
    
    var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.allowsMultipleSelectionDuringEditing = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContactPressed))
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        
        self.title = "Contacts"
        self.tableView.register(UINib.init(nibName: "ContactCell", bundle: nil), forCellReuseIdentifier: "ContactCell")
        
        if let contacts = contactsLoadService.configureContacts() {
            self.contacts = contacts
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    @objc func addContactPressed() {
        let detailsVC = ContactDetailsController(nibName: "ContactDetailsController", bundle: nil)
        detailsVC.title = "Add New Contact"
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "ContactCell"
        let contact = contacts[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ContactCell
        cell.nameLbl.text = contact.firstName + " " + contact.lastName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        let detailsVC = ContactDetailsController(nibName: "ContactDetailsController", bundle: nil)
        detailsVC.contact = contact
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
