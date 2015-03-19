//
//  JBDropDownCell.swift
//  TutorSwift
//
//  Created by Developer on 17/03/15.
//  Copyright (c) 2015 jithinpala@gmail.com. All rights reserved.
//

import UIKit

class JBDropDownCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clearColor()
        self.textLabel.textColor = UIColor.whiteColor()
        self.textLabel.font = UIFont(name: "HelveticaNeue", size: 15.0)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = CGRectOffset(self.imageView.frame, 6, 0);
        self.textLabel.frame = CGRectOffset(self.textLabel.frame, 6, 0);
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
