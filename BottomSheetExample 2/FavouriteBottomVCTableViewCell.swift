//
//  FavouriteBottomVCTableViewCell.swift
//  BananaBike
//
//  Created by Saroj on 1/24/17.
//  Copyright © 2017 Saroj. All rights reserved.
//

import UIKit

class FavouriteBottomVCTableViewCell: UITableViewCell {
    @IBOutlet weak var favoriteBtn: UIButton!
    
    @IBOutlet weak var placeLbl: UILabel!
    
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var shadowView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
