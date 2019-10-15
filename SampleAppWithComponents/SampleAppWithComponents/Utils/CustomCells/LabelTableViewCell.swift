//
//  LabelTableViewCell.swift
//  SampleAppWithComponents
//
//  Created by Rahul Mane on 19/09/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
import TTTAttributedLabel

struct LabelTableViewCellConfig : BaseCellConfig {
    var insets : UIEdgeInsets?
    var backgroundColor : UIColor?
    var labelText : NSAttributedString?
    var alignment : NSTextAlignment?
    var links : [(URL,NSRange)]?
    
    var errorMessage : NSAttributedString?
}

protocol LabelTableViewCellDelegate : class {
    func didSelectLinkWith(url: URL!)
}

class LabelTableViewCell: UITableViewCell,TTTAttributedLabelDelegate {
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    
    @IBOutlet weak var label: TTTAttributedLabel!
    weak var delegate : LabelTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(config : LabelTableViewCellConfig?){
        if let insets = config?.insets  {
            bottom.constant = insets.bottom
            top.constant = insets.top
            trailing.constant = insets.right
            leading.constant = insets.left
        }
        
        label.linkAttributes = [NSAttributedString.Key.foregroundColor : AppManager.appStyle.color(for: .link)]
        
        if let text = config?.labelText  {
            label.attributedText = text
        }
        
        if let alignment = config?.alignment{
            label.textAlignment = alignment
        }
        
        if let links = config?.links{
            links.forEach { (url, range) in
                label.addLink(to: url, with: range)
                
            }
            
            label.delegate = self
        }
        
        if let bgColor = config?.backgroundColor {
            label.backgroundColor = bgColor
        }
    }
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        delegate?.didSelectLinkWith(url: url)
    }
}
