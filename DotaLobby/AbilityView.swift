//
//  AbilityView.swift
//  
//
//  Created by Kamal Dandamudi on 5/19/16.
//
//

import UIKit

class AbilityView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet var imageView: UIImageView!

    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var abilityDescription: UITextView!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // extra function go in AFTER super.init
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // extra function go in AFTER super.init
        setup()
    }
    
    private func setup() {
        NSBundle.mainBundle().loadNibNamed("AbilityView", owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        if let view = imageView{
            let shadowPath = UIBezierPath(rect: view.bounds)
            view.layer.masksToBounds = false
            view.layer.shadowColor = UIColor.blackColor().CGColor
            view.layer.shadowOffset = CGSizeMake(0.0, 5.0)
            view.layer.shadowOpacity = 0.5
            view.layer.shadowPath = shadowPath.CGPath
        }
        self.addSubview(content)
    }

}
