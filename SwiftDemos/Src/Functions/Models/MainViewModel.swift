//
//  MainViewModel.swift
//  SwiftDemos
//
//  Created by qianzhao on 2018/4/20.
//  Copyright © 2018年 qianzhao. All rights reserved.
//

import Foundation
import UIKit

struct MainVCData {
    
    public let vclist: Dictionary<String, AnyClass> = ["SnapKit": SnapKit.self,
                                            "RxSwift" : RxSwift.self]
    
    public let needAuto = true
    public let defaultItem: String = "RxSwift"
    
    static let shareData = MainVCData()
    
    public func generateVC(vcClass: AnyClass) -> UIViewController{
        let vcType: UIViewController.Type = vcClass as! UIViewController.Type
        let vc = vcType.init()
        return vc
    }
    
}
