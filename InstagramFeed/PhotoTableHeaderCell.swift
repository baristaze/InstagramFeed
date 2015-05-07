//
//  PhotoTableHeaderCell.swift
//  InstagramFeed
//
//  Created by Baris Taze on 5/7/15.
//  Copyright (c) 2015 Baris Taze. All rights reserved.
//

import UIKit

class PhotoTableHeaderCell: UITableViewCell {

    @IBOutlet weak var userPhotoView: UIImageView!
    
    @IBOutlet weak var userNameView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
