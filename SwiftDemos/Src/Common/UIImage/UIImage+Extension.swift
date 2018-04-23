//
//  UIImage+Extension.swift
//  QBTranslator
//
//  Created by Charles Chen on 2017/8/9.
//  Copyright © 2017年 k. All rights reserved.
//

import Foundation

extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1), scale: CGFloat = UIScreen.main.scale) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, scale)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    convenience init?(letter: String, color: UIColor, size: CGSize = CGSize(width: 1, height: 1), scale: CGFloat = UIScreen.main.scale) {
        let letter = (letter as NSString).substring(to: 1)
        let rect = CGRect(origin: .zero, size: size)
        let minSide = min(size.width, size.height)
        let font = UIFont.systemFont(ofSize: minSide - 2)
        let attributes = [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font : font]
        let letterSize = (letter as NSString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        let point = CGPoint(x: (size.width - letterSize.width) / 2, y: (size.height - letterSize.height) / 2)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, scale)
        
        (letter as NSString).draw(at: point, withAttributes: attributes)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    func crop(rect: CGRect) -> UIImage? {
        func rad(_ deg: Double) -> Double {
            return deg / 180.0 * .pi
        }
        var transform: CGAffineTransform = .identity
        switch imageOrientation {
        case .left:
            transform = CGAffineTransform(rotationAngle: CGFloat(rad(90))).translatedBy(x: 0, y: -size.height)
        case .right:
            transform = CGAffineTransform(rotationAngle: CGFloat(rad(-90))).translatedBy(x: -size.width, y: 0)
        case .down:
            transform = CGAffineTransform(rotationAngle: CGFloat(rad(-180))).translatedBy(x: -size.width, y: -size.height)
        default:
            transform = .identity
        }
        transform = transform.scaledBy(x: scale, y: scale)
        guard let imageRef = cgImage?.cropping(to: rect.applying(transform)) else { return nil }
        return UIImage(cgImage: imageRef, scale: scale, orientation: imageOrientation)
    }
    
    class func generateImage(view: UIView, scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!);
        //view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
