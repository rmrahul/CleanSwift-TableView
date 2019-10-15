//
//  ButtonTableViewCell.swift
//  SampleAppWithComponents
//
//  Created by Rahul Mane on 20/09/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
struct ButtonTableViewCellConfig : BaseCellConfig {
    var insets : UIEdgeInsets?
    var backgroundColor : UIColor?
    var buttonText : NSAttributedString?
    var background : UIImage?
    var image : UIImage?
    var tintColor : UIColor?
    
    var secondaryButtonText : NSAttributedString?
    var secondaryButtonBackground : UIImage?
    var secondaryImage : UIImage?
    
    var isNeedOfSecondaryButton : Bool?
    
    var contentEdgeInsets : UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
    var secondaryContentEdgeInsets : UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)

}


class ButtonTableViewCell: UITableViewCell {
    @IBOutlet weak var bottom: NSLayoutConstraint!
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var buttonSecondary: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        button.isMultipleTouchEnabled = false
        buttonSecondary.isMultipleTouchEnabled = false
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(config : ButtonTableViewCellConfig?){

        if let insets = config?.insets  {
            bottom.constant = insets.bottom
            top.constant = insets.top
            trailing.constant = insets.right
            leading.constant = insets.left
        }
        
        if let contentInsets = config?.contentEdgeInsets{
            button.contentEdgeInsets = contentInsets
        }
        
        if let contentInsets2 = config?.secondaryContentEdgeInsets{
            buttonSecondary.contentEdgeInsets = contentInsets2
        }

        if let bg = config?.background  {
            button.setBackgroundImage(bg, for: UIControl.State.normal)
            button.imageView?.contentMode = .scaleAspectFit
        }
        
        if let title = config?.buttonText{
            button.setAttributedTitle(title, for: UIControl.State.normal)
        }
        else{
            button.setTitle("", for: UIControl.State.normal)
        }
        
        if let image = config?.image{
           // button.setTitle("", for: UIControlState.normal)
            button.setImage(image, for: UIControl.State.normal)
        }
        
        if let color = config?.tintColor{
            // button.setTitle("", for: UIControlState.normal)
            button.tintColor = color
        }
        
        if (config?.isNeedOfSecondaryButton) != nil {
            buttonSecondary.isHidden = false
            if let bg = config?.secondaryButtonBackground  {
                buttonSecondary.setBackgroundImage(bg, for: UIControl.State.normal)
            }
            
            if let title = config?.secondaryButtonText{
                buttonSecondary.setAttributedTitle(title, for: UIControl.State.normal)
            }
            
            if let image = config?.secondaryImage{
                buttonSecondary.setTitle("", for: UIControl.State.normal)
                buttonSecondary.setImage(image, for: UIControl.State.normal)
            }
        }
        else{
            buttonSecondary.isHidden = true
        }
    }
}
