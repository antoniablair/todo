//
//  TodoTableViewCell.swift
//  Crowlie
//
//  Created by Antonia Blair on 5/29/16.
//  Copyright © 2016 Antonia Blair. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var frequencyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
