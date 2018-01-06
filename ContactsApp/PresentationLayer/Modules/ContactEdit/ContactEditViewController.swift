//
//  ContactEditViewController.swift
//  ContactsApp
//
//  Created by Michael Nikolaev on 06.01.2018.
//  Copyright © 2018 Michael Nikolaev. All rights reserved.
//

import UIKit

class ContactEditViewController: UITableViewController {
    
    var cellPlaceholders = [String]()
    var cellTitles = [String?]()
    
    var contactsLoadService = ContactsLoadService()
    
    var contact: Contact? {
        didSet {
            cellTitles = contactsLoadService.loadContactFields(contact: contact!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        self.navigationItem.hidesBackButton = true
        
        self.tableView.register(UINib.init(nibName: "EditCell", bundle: nil), forCellReuseIdentifier: "EditCell")
        
        configurePlaceholders()
    }
    
    func configurePlaceholders() {
        cellPlaceholders.append("First Name")
        cellPlaceholders.append("Last Name")
        cellPlaceholders.append("Phone Number")
        cellPlaceholders.append("Street Address 1")
        cellPlaceholders.append("Street Address 2")
        cellPlaceholders.append("City")
        cellPlaceholders.append("State")
        cellPlaceholders.append("ZipCode")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func donePressed() {
        if let editVC = navigationController?.previousViewController() as? ContactDetailsController {
            if let contact = contact {
                ManagedContact.updateContact(updatedContact: contact)
            }
            editVC.contact = contact
        }
        else if navigationController?.previousViewController() is ContactsViewController {
            if let contact = contact {
                ManagedContact.addContact(newContact: contact)
            }
        }
        
        self.navigationController?.popViewController(animated: false)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellPlaceholders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "EditCell"
        let placeholder = cellPlaceholders[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! EditCell
        cell.titleTextField.placeholder = placeholder
        
        if placeholder == "First Name" {
            cell.onTitleChange = { [weak self]
                text in
                self?.contact?.firstName = text
            }
        }
        else if placeholder == "Last Name" {
            cell.onTitleChange = { [weak self]
                text in
                self?.contact?.lastName = text
            }
        }
        else if placeholder == "Phone Number" {
            cell.titleTextField.keyboardType = .phonePad
            cell.onTitleChange = { [weak self]
                text in
                self?.contact?.phoneNumber = text
            }
        }
        else if placeholder == "Street Address 1" {
            cell.onTitleChange = { [weak self]
                text in
                self?.contact?.streetAddress1 = text
            }
        }
        else if placeholder == "Street Address 2" {
            cell.onTitleChange = { [weak self]
                text in
                self?.contact?.streetAddress2 = text
            }
        }
        else if placeholder == "City" {
            cell.onTitleChange = { [weak self]
                text in
                self?.contact?.city = text
            }
        }
        else if placeholder == "State" {
            cell.onTitleChange = { [weak self]
                text in
                self?.contact?.state = text
            }
        }
        else if placeholder == "ZipCode" {
            cell.titleTextField.keyboardType = .numberPad
            cell.onTitleChange = { [weak self]
                text in
                self?.contact?.zipCode = text
            }
        }
        
        if contact == nil { return cell }
        
        if let title = cellTitles[indexPath.row] {
            cell.titleTextField.text = title
        }
        
        return cell
    }

}
