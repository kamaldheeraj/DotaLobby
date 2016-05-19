//
//  HeroTableViewCell.swift
//  DotaLobby
//
//  Created by Vensi Developer on 5/16/16.
//  Copyright © 2016 SillyApps. All rights reserved.
//

import UIKit

class HeroTableViewCell: UITableViewCell {

    
    @IBOutlet var heroImageView: UIImageView!
    
    @IBOutlet var heroNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
