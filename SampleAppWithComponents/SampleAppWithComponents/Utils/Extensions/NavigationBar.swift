//
//  NavigationBar.swift
//  SampleAppWithComponents
//
//  Created by Rahul Mane on 20/09/19.
//  Copyright © 2019 developer. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController{
    func setUpNavigationBar(){
        AppManager.appStyle.apply(to: navigationBar)
        AppManager.appStyle.apply(textStyle: .statusBar)
    }
    
    func unHideNavigationBar(){
        AppManager.appStyle.apply(textStyle: .statusBar)
        setNavigationBarHidden(false, animated: false)
    }
    
    func hideNavigationBar(){
        setStatusBarBackgroundColor(color: UIColor.clear)
        setNavigationBarHidden(true, animated: false)
    }
    
    func setStatusBarBackgroundColor(color: UIColor) {
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        
        statusBar.backgroundColor = color
    }
    
}

