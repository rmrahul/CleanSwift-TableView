//
//  ImageTableViewCell.swift
//  SampleAppWithComponents
//
//  Created by Rahul Mane on 19/09/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

struct ImageTableViewCellConfig : BaseCellConfig {
    var insets : UIEdgeInsets?
    var backgroundColor : UIColor?
    var image : UIImage?
    var alignment : UIStackView.Alignment?
    var size : CGSize?
    var aspectRatio : UIView.ContentMode?
}

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var width: NSLayoutConstraint!
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var imgview: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(config : ImageTableViewCellConfig?){
        if let insets = config?.insets  {
            bottom.constant = insets.bottom
            top.constant = insets.top
            trailing.constant = insets.right
            leading.constant = insets.left
        }
        if let image = config?.image  {
            imgview.image = image
        }
        
        if let alignment = config?.alignment{
            stackview.alignment = alignment
        }
        
        if let size = config?.size  {
            width.constant = size.width
            height.constant = size.height
        }

        if let ratio = config?.aspectRatio{
            imgview.contentMode = ratio
        }
    }
    
}
