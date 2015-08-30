//
//  MovieCell.swift
//  RottenTomatoes
//
//  Created by Nguyen Duy Hung on 8/30/15.
//  Copyright (c) 2015 Nguyen Duy Hung. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
