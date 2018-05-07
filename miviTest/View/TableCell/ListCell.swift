//
//  ListCell.swift
//  miviTest
//
//  Created by user on 07/05/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
