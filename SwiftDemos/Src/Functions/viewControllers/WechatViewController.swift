//
//  WechatViewController.swift
//  SwiftDemos
//
//  Created by qianzhao on 2018/4/25.
//  Copyright © 2018年 qianzhao. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class WechatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.edgesForExtendedLayout = .bottom
        initUI()
        configEvents()
    }
    
    func initUI() -> Void {
        view.addSubview(button1)
        button1.snp.makeConstraints { (make) in
            make.top.equalTo(30)
            make.width.equalTo(200)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
        }
    }
    
    func configEvents() -> Void {
        button1.rx.tap.subscribe(onNext: { [weak self]() in
            print("clicked :\(self!)")
            WXApiWrap.shared.quickLogin()
        }).disposed(by: dispostBag)
    }
    
    let button1: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitle("Login clicked", for: .highlighted)
        button.backgroundColor = .red
        return button
    }()
    let dispostBag = DisposeBag()
}
