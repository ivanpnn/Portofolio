//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Macbook on 12/12/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet var messageView: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var myAvatar: UIImageView!
    @IBOutlet var youAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageLabel.textColor  = .white
        messageView.layer.cornerRadius = messageLabel.frame.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
