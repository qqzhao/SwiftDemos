//
//  MyScreenLabel.swift
//  SwiftDemos
//
//  Created by qianzhao on 2018/4/20.
//  Copyright © 2018年 qianzhao. All rights reserved.
//

import UIKit

class MyScreenLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textAlignment = NSTextAlignment.center
        self.backgroundColor = UIColor.gray
        NSLog("test in MyScreen Label")
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textAlignment = NSTextAlignment.center
        self.backgroundColor = UIColor.gray
        NSLog("test in MyScreen Label")
    }
}
