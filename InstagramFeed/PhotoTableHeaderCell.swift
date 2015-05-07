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
        
        /*
        self.userPhotoView.frame = CGRect(x:2, y:2, width:self.frame.height-4, height:self.frame.height-4)
        self.userNameView.frame = CGRect(x:self.userPhotoView.frame.width + 4, y:2, width:self.frame.width - self.userPhotoView.frame.width - 6, height:self.frame.height-4)
        
        self.userPhotoView.layer.cornerRadius = self.userPhotoView.frame.size.width / 2
        self.userPhotoView.clipsToBounds = true
        */
        
        self.userPhotoView.frame = CGRect(x:0, y:5, width:50, height:50)
        self.userNameView.frame = CGRect(x:52, y:5, width:268, height:50)
        
        self.userPhotoView.layer.cornerRadius = 25
        self.userPhotoView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
