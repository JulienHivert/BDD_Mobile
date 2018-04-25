//
//  CustomCell.swift
//  iOS_BDD_Do_It
//
//  Created by Clement Burellier on 25/04/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var nameCell: UILabel!
    
    @IBOutlet weak var descCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //cached items lazy var
    //let item
    
    

    

}
