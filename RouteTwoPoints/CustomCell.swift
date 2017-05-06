//
//  CustomCell.swift
//  RouteTwoPoints
//
//  Created by My Vo on 4/7/17.
//  Copyright © 2017 My Vo. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    
    
    @IBOutlet weak var cellImages: UIImageView!
    
    @IBOutlet weak var cellName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
