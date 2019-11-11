//
//  BusinessCell.swift
//  Yelp
//
//  Created by Anirudh V on 8/3/18.
//  Copyright © 2018 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    @IBOutlet weak var Distance: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var Address: UILabel!
    @IBOutlet weak var Reviewsimage: UIImageView!
    @IBOutlet weak var reviewscount: UILabel!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Thumbimage: UIImageView!
    
    var business:Business!{
        didSet{
            Title.text = business.name
            Thumbimage.setImageWith(business.imageURL!)
            Distance.text = business.distance
            Description.text = business.categories
            Address.text = business.address
            reviewscount.text = "\(business.reviewCount!) Reviews"
            Reviewsimage.image = business.ratingImage
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Thumbimage.layer.cornerRadius = 3
        Thumbimage.clipsToBounds = true
        
        Title.preferredMaxLayoutWidth = Title.frame.size.width
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        Title.preferredMaxLayoutWidth = Title.frame.size.width
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
