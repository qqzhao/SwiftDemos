//
//  UIView+Expand.swift
//  SwiftDemos
//
//  Created by qianzhao on 2018/4/25.
//  Copyright © 2018年 qianzhao. All rights reserved.
//

import UIKit

extension UIView{
    public func width() -> CGFloat{
        return self.bounds.size.width
    }
    
    public func height() -> CGFloat{
        return self.bounds.size.height
    }
    
    public func x() -> CGFloat{
        return self.frame.origin.x
    }
    
    public func y() -> CGFloat{
        return self.frame.origin.y
    }
}
