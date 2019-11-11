//
//  ChatCellTableViewCell.swift
//  Chat app
//
//  Created by Anirudh V on 8/9/18.
//  Copyright © 2018 Anirudh V. All rights reserved.
//

import UIKit

class ChatCellTableViewCell: UITableViewCell {

    @IBOutlet weak var Username: UILabel!
    @IBOutlet weak var message: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public var mess: String = "" {
        didSet {
            message.text = mess
        }
    }
    
    public var username: String = "" {
        didSet {
            Username.text = username
            if username == "EMPTY"{
                Username.text = "🤖"
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
