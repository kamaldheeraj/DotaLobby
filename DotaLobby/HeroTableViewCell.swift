//
//  HeroTableViewCell.swift
//  DotaLobby
//
//  Created by Kamal Dandamudi on 5/16/16.
//  Copyright © 2016 SillyApps. All rights reserved.
//

import UIKit

class HeroTableViewCell: UITableViewCell {

    
    @IBOutlet var heroImageView: UIImageView!
    
    @IBOutlet var heroNameLabel: UILabel!
    
    var hero:Hero?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let view = heroImageView{
            let shadowPath = UIBezierPath(rect: view.bounds)
            view.layer.masksToBounds = false
            view.layer.shadowColor = UIColor.blackColor().CGColor
            view.layer.shadowOffset = CGSizeMake(0.0, 5.0)
            view.layer.shadowOpacity = 0.5
            view.layer.shadowPath = shadowPath.CGPath
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
