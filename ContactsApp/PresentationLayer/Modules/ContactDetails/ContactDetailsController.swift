//
//  ContactDetailsController.swift
//  ContactsApp
//
//  Created by Michael Nikolaev on 06.01.2018.
//  Copyright © 2018 Michael Nikolaev. All rights reserved.
//

import UIKit

class ContactDetailsController: UITableViewController {
    
    var cellTitles = [String?]()
    var contactsLoadService = ContactsLoadService()
    
    var contact: Contact! {
        didSet {
            self.title = contact.firstName + " " + contact.lastName
            cellTitles = contactsLoadService.loadContactFields(contact: contact)
            cellTitles.removeFirst()
            cellTitles.removeFirst()
            cellTitles = cellTitles.filter { $0 != nil }
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editPressed))
        
        self.tableView.register(UINib.init(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: "DetailCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func editPressed() {
        let editVC = ContactEditViewController(nibName: "ContactEditViewController", bundle: nil)
        editVC.title = "Edit Contact"
        editVC.contact = contact
        self.navigationController?.pushViewController(editVC, animated: false)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "DetailCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! DetailCell
        cell.titleLbl.text = cellTitles[indexPath.row]
        
        return cell
    }
}
