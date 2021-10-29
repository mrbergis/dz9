//
//  ToDoTableViewCell.swift
//  dz9
//
//  Created by Андрей Адельбергис on 26.10.2021.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var taskTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
