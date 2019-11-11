//
//  PostCell.swift
//  Instagram
//
//  Created by Anirudh V on 8/10/18.
//  Copyright © 2018 Anirudh V. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
