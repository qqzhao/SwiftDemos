//
//  UIColor+Util.swift
//  QBTranslator
//

import Foundation

extension UIColor {
    public class func test1() -> Void {
        print("test1")
    }
}

public final class TestClass1: NSObject {
    public static let test2: String = "aaa"
//    public class let test3: String = "bbb"// 不支持这样的声明
    public static func test1() -> Void {
        print("in TestClass1")
    }
    
    public class func test4() -> Void { // 类方法在模块外部访问不了
        print("in TestClass1 test4")
    }
    
    func test5() -> Void {
        print("test5")
    }
}
