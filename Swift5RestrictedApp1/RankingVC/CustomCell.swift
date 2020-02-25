//
//  CustomCell.swift
//  Swift5RestrictedApp1
//
//  Created by 宮本一成 on 2020/02/15.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.backgroundColor = CGColor(srgbRed: 1, green: 1, blue: 1, alpha: 1)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
