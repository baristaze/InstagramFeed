//
//  PhotoTableViewCell.swift
//  InstagramFeed
//
//  Created by Baris Taze on 5/6/15.
//  Copyright (c) 2015 Baris Taze. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var photoItemView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
