//
//  ViewController.swift
//  SwiftDemos
//
//  Created by qianzhao on 2018/4/20.
//  Copyright © 2018年 qianzhao. All rights reserved.
//

import UIKit
import SnapKit

let dataDic = MainVCData.shareData.vclist

class ViewController: UIViewController {
    lazy var tableview = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Main"
        initTable()
        dealyPerform()
    }
}

extension ViewController{
    func initTable() -> Void {
        tableview.frame.size = self.view.bounds.size
        NSLog("self.bound = \(tableview.frame)")
        tableview.delegate = self
        tableview.dataSource = self
        self.view.addSubview(tableview)
    }
    
    func dealyPerform() -> Void {
        if (!MainVCData.shareData.needAuto) {
            return
        }
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            let item: String = MainVCData.shareData.defaultItem
            let vcClass: AnyClass = (dataDic[item])!
            let vc = MainVCData.shareData.generateVC(vcClass: vcClass)
            vc.title = item
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MyCustomCell  = MyCustomCell()
        let arr: Array = dataDic.map{"\($1)"}
        cell.setText(text: "\(arr[indexPath.row])")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arr: Array = dataDic.map{"\($0)"}
        return arr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt index = \(index)")
        
        let keys = Array(dataDic.keys)
        let values2 = dataDic.map{ $0.1 }
        
        let vcClass :AnyClass = values2[indexPath.row]
        let vc = MainVCData.shareData.generateVC(vcClass: vcClass)
        
        vc.title = keys[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

class MyCustomCell: UITableViewCell{
    let suffView = UILabel()
    private let testA: String = "test"
    fileprivate let testB: String = "test"
    public let testC: String = "test"
    open let testD: String = "test"
    required override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSuffView()
    }
    
    func initSuffView () -> Void{
        let supV = self
        suffView.backgroundColor = UIColor.lightGray
        suffView.textAlignment = NSTextAlignment.center
        supV.addSubview(suffView)
        suffView.snp.makeConstraints { (make) in
            make.height.equalTo(supV).dividedBy(1)
            make.width.equalTo(supV).dividedBy(1)
            make.center.equalTo(supV)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setText(text: String) -> Void {
        suffView.text = text
    }
}

extension MyCustomCell{
    func test() -> Void {
        print("test = \(testA)") // swift 3.3 的时候编译出错，swift4.1的时候又没有问题了。说明4.1又放开了限制。
        print("test = \(testB)")
        print("test = \(testC)")
        print("test = \(testD)")
    }
}


