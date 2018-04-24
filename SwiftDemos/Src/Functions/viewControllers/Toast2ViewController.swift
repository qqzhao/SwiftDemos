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
import SwiftToast

class Toast2ViewController: UIViewController {
    
    let dispostBag = DisposeBag()
    private let scrollView: UIScrollView = {
        let scrollview: UIScrollView = UIScrollView()
        return scrollview
    }()
    var buttons = [UIButton]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.edgesForExtendedLayout = .bottom
        self.extendedLayoutIncludesOpaqueBars = false;
        initUI()
    }
    
    func initUI(){
        self.view.addSubview(scrollView)
        scrollView.backgroundColor = .green
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.width(), height: self.view.height())
        setupButtons()
    }
    
    func setupButtons() -> Void {
        let itemH = 80
        let supV = scrollView
        let spaceH = itemH + 10
        let items = [1,2,3,4,5,6,7]
        for item in items {
            //            print("item = \(item)")
            let button = UIButton()
            button.setTitle("button(\(item))", for: .normal)
            button.setTitle("click button(\(item))", for: .highlighted)
            supV.addSubview(button)
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
        scrollView.contentSize = CGSize(width: UIScreen.width, height: CGFloat(items.count * spaceH + 230))
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
        case 7:
            button.rx.tap.subscribe (onNext: { [weak self] () in
                self!.testToast7()
            }).disposed(by: dispostBag)
        default:
            print("item default")
        }
    }
}

extension Toast2ViewController{
    func testToast1() -> Void{
        print("toast1")
//        let toast =  SwiftToast(text: "This is a SwiftToast",
//                               duration: nil,
//                               isUserInteractionEnabled: false)
//        present(toast, animated: true)
    }
    func testToast2() -> Void{
        print("toast2")
    }
    func testToast3() -> Void{
        print("toast3")
    }
    func testToast4() -> Void{
        print("toast4")
    }
    
    func testToast5() -> Void{
        print("toast5")
    }
    
    func testToast6() -> Void{
        print("toast6")
    }
    func testToast7() -> Void{
        print("toast7")
    }
}
