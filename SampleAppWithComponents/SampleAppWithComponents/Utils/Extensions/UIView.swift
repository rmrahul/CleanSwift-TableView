//
//  UIView.swift
//  SampleAppWithComponents
//
//  Created by Rahul Mane on 23/09/18.
//  Copyright © 2018 developer. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}

extension Collection {
    
    func chunked(by distance: Int) -> [[Element]] {
        precondition(distance > 0, "distance must be greater than 0") // prevents infinite loop
        
        var index = startIndex
        let iterator: AnyIterator<Array<Element>> = AnyIterator({
            let newIndex = self.index(index, offsetBy: distance, limitedBy: self.endIndex) ?? self.endIndex
            defer { index = newIndex }
            let range = index ..< newIndex
            return index != self.endIndex ? Array(self[range]) : nil
        })
        
        return Array(iterator)
    }
    
}

extension UITableView {
    public func refresh(){
        self.beginUpdates()
        UIView.setAnimationsEnabled(false)
        self.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
}

extension UIViewController {
    func addLeftMenuButton(){
        //let testUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "editProfile"), style: .plain, target: self, action: nil)
        //self.navigationItem.rightBarButtonItem  = testUIBarButtonItem
    }
    
    func hideBackButton(){
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.leftBarButtonItems = nil
    }
    
    func changeLeftNavigationItemToCross(){
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "")
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
        space.width = 15
        
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(named: "backArrow"), for: UIControl.State.normal)
        btnLeftMenu.addTarget(self, action: #selector(UIViewController.btnbackClicked), for: UIControl.Event.touchUpInside)
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 33/2, height: 27/2)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItems = [space,barButton] as! [UIBarButtonItem]
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    
    func addRightButton(image : UIImage,target : Any?,selector : Selector?){
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(image, for: UIControl.State.normal)
        if let selector = selector{
            btnLeftMenu.addTarget(target, action: selector, for: UIControl.Event.touchUpInside)
        }
        //btnLeftMenu.addTarget(self, action: #selector(UIViewController.btnbackClicked), for: UIControlEvents.touchUpInside)
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 33/2, height: 27/2)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.rightBarButtonItems = [barButton]
    }
    
    
    @objc func btnbackClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func addBackground(imageName : String){
        let imView = UIImageView(frame: self.view.bounds)
        imView.image = UIImage(named: imageName)
        self.view.addSubview(imView)
    }
    
    func addBackgroundUnderNavivationView(imageName : String){
        let imView = UIImageView(frame: (self.navigationController?.view.bounds)!)
        imView.image = UIImage(named: imageName)
        self.navigationController?.view.addSubview(imView)
    }
}



extension CALayer {
    public func addGradienBorder(colors:[UIColor],width:CGFloat = 1,rect : CGRect) {
        let objgradientLayer = CAGradientLayer()
        objgradientLayer.frame =  rect
        objgradientLayer.colors = colors
        
        let objShapeLayer = CAShapeLayer()
        objShapeLayer.lineWidth = 5
        objShapeLayer.path = UIBezierPath(rect: self.bounds).cgPath
        objShapeLayer.fillColor = UIColor.red.cgColor
        objShapeLayer.strokeColor = UIColor.black.cgColor
        objgradientLayer.mask = objShapeLayer
        
        self.addSublayer(objgradientLayer)
    }
}

extension UIView{
    public func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}

