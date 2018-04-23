//
//  RxSwift.swift
//  SwiftDemos
//
//  Created by qianzhao on 2018/4/20.
//  Copyright © 2018年 qianzhao. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import RxCocoa

class RxSwift: UIViewController {
    let button: UIButton = UIButton()
    let myLabel = OCTestLabel()
    var disposeBag: DisposeBag? = DisposeBag()
    var counter: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        initButton()
        initLabel()
    }
}

extension RxSwift {
    func initButton() {
        print("RxSwift initButton")
        let supV: UIView = self.view
        supV.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.width.equalTo(supV).dividedBy(3)
            make.height.equalTo(50)
            make.center.equalTo(supV)
        }
        
        button.setTitle("点击按钮", for: UIControlState.normal)
        button.setTitle("取消点击", for: UIControlState.highlighted)
        button.backgroundColor = UIColor.red
        button.rx.tap
            .subscribe(onNext: {
                print("button Tapped: \(self.counter)")
                self.counter += 1
                if (self.counter == 2) {
                    print("disposeBag tragger")
                    self.disposeBag = nil
                }
            })
            .disposed(by: disposeBag!)
        
        button.rx.tap
            .subscribe(onNext: {
                print("button Tapped@@2222: \(self.counter)")
            })
            .disposed(by: disposeBag!)
        print("self.disposeBag = \(self.disposeBag)")
    }
    
    func initLabel() -> Void {
        let supV: UIView = self.view
        supV.addSubview(myLabel)
        myLabel.backgroundColor = .yellow
        myLabel.textAlignment = .center
        myLabel.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.top.equalTo(button.snp.bottom)
            make.centerX.equalTo(supV)
        }
    }
}

//extension DisposeBag{
//    func printBag(){
//        print("\(_disposables)")
//    }
//}



