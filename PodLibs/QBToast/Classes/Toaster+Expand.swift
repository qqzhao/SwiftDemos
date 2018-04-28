//
//  Toaster+Expand.swift
//  SwiftDemos
//
//  Created by qianzhao on 2018/4/24.
//  Copyright © 2018年 qianzhao. All rights reserved.
//

import UIKit
import Toaster

public enum ToastPos {
    case top, bottom, center
}

public class QBToaster: NSObject{
    static func defaultConfig() {
        ToastView.appearance().backgroundColor = UIColor(rgb: 0x000000, alpha: 0.5)
        ToastView.appearance().textInsets = UIEdgeInsetsMake(10, 20, 10, 20)
        ToastView.appearance().font = UIFont.systemFont(ofSize: 16)
        ToastView.appearance().textColor = UIColor.white
    }
    
    public static func showText(_ text: String?, pos: ToastPos) -> Void{
        defaultConfig()
        var bottomOffset: CGFloat = 30.0
        switch pos {
        case .top:
            bottomOffset = UIScreen.main.bounds.size.height - (64 + 30 + 40 + 20)
        case .center:
            bottomOffset = UIScreen.main.bounds.size.height / 2 - 20.0
        case .bottom:
            bottomOffset = 30.0
//        default:
//            bottomOffset = UIScreen.main.bounds.size.height / 2 - 20.0
        }
        ToastView.appearance().bottomOffsetPortrait = bottomOffset
        ToastCenter.default.cancelAll()
        let toast = Toast(text: text, delay: 0, duration: Delay.short)
        toast.show()
    }
}

extension UIColor {
    convenience init(rgb: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    convenience init(hex: String, alpha: CGFloat = 1) {
        var cString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        var alpha = alpha
        if (cString as NSString).length >= 8 {
            let aString = (cString as NSString).substring(to: 2)
            cString = (cString as NSString).substring(from: 2)
            var a: CUnsignedInt = 0
            Scanner(string: aString).scanHexInt32(&a)
            alpha = CGFloat(a) / 255.0
        }
        
        var rString = "FF"
        if (cString as NSString).length >= 2 {
            rString = (cString as NSString).substring(to: 2)
            cString = (cString as NSString).substring(from: 2)
        }
        var gString = "FF"
        if (cString as NSString).length >= 2 {
            gString = (cString as NSString).substring(to: 2)
            cString = (cString as NSString).substring(from: 2)
        }
        var bString = "FF"
        if (cString as NSString).length >= 2 {
            bString = (cString as NSString).substring(to: 2)
        }
        
        var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        self.init(red:CGFloat(r) / 255.0, green:CGFloat(g) / 255.0, blue:CGFloat(b) / 255.0, alpha: alpha)
    }
}
