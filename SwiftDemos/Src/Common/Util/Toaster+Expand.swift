//
//  Toaster+Expand.swift
//  SwiftDemos
//
//  Created by qianzhao on 2018/4/24.
//  Copyright © 2018年 qianzhao. All rights reserved.
//

import UIKit
import Toaster

enum ToastPos {
    case top, bottom, center
}

extension Toast{
    class func defaultConfig() {
        ToastView.appearance().backgroundColor = UIColor(rgb: 0x000000, alpha: 0.5)
        ToastView.appearance().textInsets = UIEdgeInsetsMake(10, 20, 10, 20)
        ToastView.appearance().font = UIFont.systemFont(ofSize: 16)
        ToastView.appearance().textColor = UIColor.white
    }
    
    class func showText(_ text: String?, pos: ToastPos) -> Void{
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
        let toast = Toast(text: text, delay: 0, duration: Delay.long)
        toast.show()
    }
}
