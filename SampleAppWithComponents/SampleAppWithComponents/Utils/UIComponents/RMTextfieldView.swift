//
//  RMTextfieldView.swift
//  SampleAppWithComponents
//
//  Created by Rahul Mane on 11/09/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

public class RMTextfieldView: UIView {
    let kCONTENT_XIB_NAME = "RMTextfieldView"
    @IBOutlet var containerView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var placeholder: UILabel!
    @IBOutlet weak var lblError: UILabel!

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        setUpTextfield()
        setUpBorder()
        hideError()
    }
    
    private func setUpTextfield(){
        textfield.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        placeholder.text = textfield.placeholder
        
    }
    
    private func setUpBorder(){
        borderView.backgroundColor = UIColor.clear
        borderView.layer.borderWidth = 1.0
        borderView.layer.borderColor = UIColor.lightGray.cgColor
        borderView.layer.cornerRadius = 5.0
//        borderView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func updateBackgroundColor(color : UIColor){
        self.backgroundColor = color
        self.containerView.backgroundColor = color
        self.borderView.backgroundColor = color
        self.contentView.backgroundColor = color
        self.textfield.backgroundColor = color
        self.lblError.backgroundColor = color
        self.placeholder.backgroundColor = color
    }
    
    func updatePlaceholder(placeHolder : String){
        placeholder.text = placeHolder
        textfield.placeholder = placeHolder
        let attributes = [NSAttributedString.Key.foregroundColor : AppManager.appStyle.color(for: .title),
                          NSAttributedString.Key.font : AppManager.appStyle.font(for: .title)]

        textfield.attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                               attributes: attributes)
    }
    
    func showError(str : NSAttributedString){
        lblError.isHidden = false
        lblError.attributedText = str
    }
    
    func hideError(){
        lblError.isHidden = true
        lblError.attributedText = NSAttributedString(string: "No error")
    }
    
    func addRightButton(image : UIImage, selecteImage : UIImage? = nil) -> UIButton{
        let button = UIButton(type: .custom)
        button.setTitle("", for: UIControl.State.normal)
        button.setImage(image, for: .normal)
        
        if let selected = selecteImage {
            button.setImage(selected, for: .selected)
        }
        button.frame = CGRect(x: 0, y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        textfield.rightView = button
        textfield.rightViewMode = .always
        return button
    }
    
    func addLeftButton(title : String) -> UIButton{
        let button = UIButton(type: .custom)
        button.tintColor = UIColor.black
        button.setTitle(title, for: UIControl.State.normal)
        button.frame = CGRect(x: 0, y: CGFloat(0), width: CGFloat(40), height: self.textfield.bounds.height)
        button.setTitleColor(textfield.textColor, for: UIControl.State.normal)
        textfield.leftView = button
        textfield.leftViewMode = .always
        return button
    }
    
    func setText(text : String?){
        guard let passed = text,!passed.isEmpty else {
            placeholder.isHidden = true
            joinTheBorder()
            textfield.text = text
            return
        }
        textfield.text = passed
        cutTheBorder()
        //placeholder.isHidden = false
        placeholder.isHidden = true
    }
    
    @objc func rightPannelTaped(_ sender: Any) {
        
    }
    
    @objc func textFieldDidChange(textfield : UITextField){
        guard let text = textfield.text,!text.isEmpty else {
            placeholder.isHidden = true
            joinTheBorder()
            return
        }
        cutTheBorder()
        //return placeholder.isHidden = false
        return placeholder.isHidden = true
    }
    
    private func cutTheBorder(){
        return;
        let path = CGMutablePath()
        path.addRect(CGRect(x: 8, y: 0, width: self.placeholder.intrinsicContentSize.width+5, height: 4))
        path.addRect(CGRect(origin: .zero, size: borderView.bounds.size))
        
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.red.cgColor
        maskLayer.path = path
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        
        borderView.layer.mask = maskLayer
        borderView.clipsToBounds = true
    }
    
    private func joinTheBorder(){
        return;
        borderView.layer.mask = nil
    }
}



