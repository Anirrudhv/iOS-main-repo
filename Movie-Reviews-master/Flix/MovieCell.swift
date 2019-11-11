//
//  MovieCell.swift
//  Flix
//
//  Created by Anirudh V on 7/27/18.
//  Copyright © 2018 Anirudh V. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

  
    @IBOutlet weak var PosterImage: UIImageView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Overview: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
