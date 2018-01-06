//
//  EditCell.swift
//  ContactsApp
//
//  Created by Michael Nikolaev on 06.01.2018.
//  Copyright © 2018 Michael Nikolaev. All rights reserved.
//

import UIKit

class EditCell: UITableViewCell {

    @IBOutlet weak var titleTextField: UITextField!
    
    var onTitleChange: ((_ text: String) -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func titleChanged(_ sender: Any) {
        onTitleChange(titleTextField.text!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
