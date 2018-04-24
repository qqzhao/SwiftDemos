//
//  ToastViewController.swift
//  SwiftDemos
//
//  Created by qianzhao on 2018/4/24.
//  Copyright © 2018年 qianzhao. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Toaster

class ToastViewController: UIViewController {
    
    let dispostBag = DisposeBag()
    var buttons = [UIButton]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupButtons()
    }
    
    func setupButtons() -> Void {
        let itemH = 80
        let spaceH = itemH + 10
        for item in [1,2,3,4,5,6] {
//            print("item = \(item)")
            let button = UIButton()
            button.setTitle("button(\(item))", for: .normal)
            button.setTitle("click button(\(item))", for: .highlighted)
            self.view.addSubview(button)
            button.backgroundColor = .gray
//            print("button = \(button)")
            button.snp.makeConstraints { (make) in
                make.width.equalToSuperview()
                make.height.equalTo(itemH)
                make.left.equalToSuperview()
                make.top.equalTo(item * spaceH)
            }
            configEvents(button, index: item)
            buttons.append(button)
        }
    }
    
    func configEvents(_ button :UIButton, index:Int) -> Void {
//        print("index = \(index)")
        switch index {
        case 1:
            button.rx.tap.subscribe(onNext: { [weak self]() in
                self!.testToast1()
            }).disposed(by: dispostBag)
        case 2:
            button.rx.tap.subscribe (onNext: { [weak self] () in
                self!.testToast2()
            }).disposed(by: dispostBag)
        case 3:
            button.rx.tap.subscribe (onNext:  { [weak self] () in
                self!.testToast3()
            }).disposed(by: dispostBag)
        case 4:
            button.rx.tap.subscribe (onNext: { [weak self] () in
                self!.testToast4()
            }).disposed(by: dispostBag)
        case 5:
            button.rx.tap.subscribe (onNext: { [weak self] () in
                self!.testToast5()
            }).disposed(by: dispostBag)
        case 6:
            button.rx.tap.subscribe (onNext: { [weak self] () in
                self!.testToast6()
            }).disposed(by: dispostBag)
        default:
            print("item default")
        }
    }
}

extension ToastViewController{
    func testToast1() -> Void{
        print("toast1")
        ToastView.appearance().bottomOffsetPortrait = 30
        ToastView.appearance().backgroundColor = .gray
        ToastView.appearance().textInsets = UIEdgeInsetsMake(30, 20, 30, 20)
        let toast = Toast(text: "hello world, how are you!", delay: 0, duration: 3.0)
        toast.show()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//            toast.cancel()
//        }
    }
    func testToast2() -> Void{
        print("toast2")
        ToastView.appearance().backgroundColor = .red
        let toast = Toast(text: "Hello, world!", duration: Delay.long)
        toast.show()
    }
    func testToast3() -> Void{
        print("toast3")
        ToastView.appearance().textInsets = UIEdgeInsetsMake(100, 20, 100, 20)
        ToastView.appearance().bottomOffsetPortrait = UIScreen.main.bounds.size.height / 2 - 20
        let toast = Toast(text: "Hello, world!", duration: Delay.long)
        toast.show()
    }
    func testToast4() -> Void{
        print("toast4")
        QBToast.showText("hello world!", pos: .center)
    }
    
    func testToast5() -> Void{
        print("toast5")
        QBToast.showText("hello world!", pos: .top)
    }
    
    func testToast6() -> Void{
        print("toast6")
        QBToast.showText("hello world!", pos: .bottom)
    }
}
