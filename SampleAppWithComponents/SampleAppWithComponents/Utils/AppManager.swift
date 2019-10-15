//
//  AppManager.swift
//  SampleAppWithComponents
//
//  Created by Rahul Mane 20/09/18 .
//  Copyright © 2018 Developer . All rights reserved.
//

import UIKit
import SwiftHEXColors

struct AppManager {    
    enum TextStyle {
        case tableview
        case statusBar
        case header
        case navigationBar
        case title
        case subtitle
        case placeHolder
        case error
        case errorBackgroud
        case body
        case button
        case tabbar
        case link
        case speciality
        case menu
    }
    
    struct TextAttributes {
        let font: UIFont
        let color: UIColor
        let backgroundColor: UIColor?
        
        init(font: UIFont, color: UIColor, backgroundColor: UIColor? = nil) {
            self.font = font
            self.color = color
            self.backgroundColor = backgroundColor
        }
    }
    
    // MARK: - General Properties
    let backgroundColor: UIColor
    let preferredStatusBarStyle: UIStatusBarStyle
    let appThemeColor = UIColor(hexString:"#3BAAD1")
    
    let attributesForStyle: (_ style: TextStyle) -> TextAttributes

    init(backgroundColor: UIColor,
         preferredStatusBarStyle: UIStatusBarStyle = .default,
         attributesForStyle: @escaping (_ style: TextStyle) -> TextAttributes){
        self.backgroundColor = backgroundColor
        self.preferredStatusBarStyle = preferredStatusBarStyle
        self.attributesForStyle = attributesForStyle
    }
    
    // MARK: - Convenience Getters
    func font(for style: TextStyle) -> UIFont {
        return attributesForStyle(style).font
    }
    
    func color(for style: TextStyle) -> UIColor {
        return attributesForStyle(style).color
    }
    
    func backgroundColor(for style: TextStyle) -> UIColor? {
        return attributesForStyle(style).backgroundColor
    }
    
    func apply(textStyle: TextStyle, to label: UILabel) {
        let attributes = attributesForStyle(textStyle)
        
        label.font = attributes.font
        label.textColor = attributes.color
        label.backgroundColor = attributes.backgroundColor
    }
    
    func apply(textStyle: TextStyle = .button, to button: UIButton) {
        let attributes = attributesForStyle(textStyle)
        button.setTitleColor(attributes.color, for: .normal)
        button.titleLabel?.font = attributes.font
        button.backgroundColor = attributes.backgroundColor
    }
    
    func apply(textStyle: TextStyle = .navigationBar, to navigationBar: UINavigationBar) {
        let attributes = attributesForStyle(textStyle)
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: attributes.font,
            NSAttributedString.Key.foregroundColor: attributes.color
        ]
        
        if let color = attributes.backgroundColor {
            navigationBar.barTintColor = color
        }
        
        navigationBar.tintColor = attributes.color
        navigationBar.barStyle = preferredStatusBarStyle == .default ? .default : .black
    }
    
    func apply(textStyle: TextStyle = .tableview, to tableview : UITableView){
        let attributes = attributesForStyle(textStyle)
        
        tableview.backgroundColor = attributes.backgroundColor
    }
    
    func apply(textStyle: TextStyle = .statusBar){
        let attributes = attributesForStyle(textStyle)
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        
        statusBar.backgroundColor = attributes.backgroundColor
    }

    func apply(textStyle: TextStyle = .tabbar, to tabBar: UITabBar) {
        let attributes = attributesForStyle(textStyle)
        tabBar.tintColor = attributes.backgroundColor
    }
}

extension AppManager{    
    static var appStyle: AppManager {
        return AppManager(
            backgroundColor: .black,
            preferredStatusBarStyle: .lightContent,
            attributesForStyle: { $0.appAttributes }
        )
    }
    
}

private extension AppManager.TextStyle{
    
    var appAttributes : AppManager.TextAttributes{
        switch self {
        case .header:
            return AppManager.TextAttributes(font: UIFont.systemFont(ofSize: 20), color: UIColor(hexString:"#FFFFFF")!, backgroundColor: UIColor(hexString:"#3BAAD1"))
        case .tabbar:fallthrough
        case .navigationBar:
            return AppManager.TextAttributes(font: UIFont.systemFont(ofSize: 18), color: UIColor(hexString:"#FFFFFF")!, backgroundColor: UIColor(hexString:"#3BAAD1"))
        case .tableview:
            return AppManager.TextAttributes(font: UIFont(name: "AvenirNext-DemiBold", size: 16.0)!, color: UIColor(hexString:"#FFFFFF")!, backgroundColor: UIColor(hexString:"#F9FDFF"))
        case .statusBar:
            return AppManager.TextAttributes(font: UIFont(name: "AvenirNext-DemiBold", size: 16.0)!, color: UIColor(hexString:"#FFFFFF")!, backgroundColor: UIColor(hexString:"#3BAAD1"))
        case .title:
            return AppManager.TextAttributes(font: UIFont.systemFont(ofSize: 15), color: UIColor(hexString:"#6B6B6B")!, backgroundColor: .white)
        case .link:
            return AppManager.TextAttributes(font: UIFont.systemFont(ofSize: 15), color: UIColor.blue, backgroundColor: .clear)
        case .subtitle:
            return AppManager.TextAttributes(font: UIFont.systemFont(ofSize: 13), color: UIColor(hexString:"#6B6B6B")!, backgroundColor: .white)
        case .placeHolder:
            return AppManager.TextAttributes(font: UIFont.systemFont(ofSize: 11), color: UIColor(hexString:"#6B6B6B")!, backgroundColor: .white)
        case .speciality:
            return AppManager.TextAttributes(font: UIFont.systemFont(ofSize: 11), color: UIColor(hexString:"#6B6B6B")!, backgroundColor: .white)
        case .error:
            return AppManager.TextAttributes(font: UIFont.systemFont(ofSize: 13), color: UIColor.red, backgroundColor: .white)
        case .errorBackgroud:            
            return AppManager.TextAttributes(font: UIFont.systemFont(ofSize: 13), color: UIColor(hexString: "#FFF6F6")!, backgroundColor: .white)
        case .body:
            return AppManager.TextAttributes(font: UIFont(name: "AvenirNext-Regular", size: 14.0)!, color: UIColor(hexString:"#363636")!, backgroundColor: .white)
        case .button:
            return AppManager.TextAttributes(font: UIFont.systemFont(ofSize: 18), color: UIColor.white, backgroundColor: UIColor.clear)
        case .menu:
            return AppManager.TextAttributes(font: UIFont.systemFont(ofSize: 15), color: UIColor.black, backgroundColor: UIColor.clear)
        }
    }
}

