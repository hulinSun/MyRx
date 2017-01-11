//
//  UIImage+Extension.swift
//  MyRx
//
//  Created by Hony on 2017/1/4.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import CoreGraphics
import  CoreFoundation

extension UIImage{
    
    class func creatImage(with color: UIColor) -> UIImage{
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setFillColor(color.cgColor)
        ctx?.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    class func handleImage(originalImage: UIImage,size: CGSize)-> UIImage{
        let originalsize = originalImage.size
        print("改变前图片尺寸\(originalsize)")
        if (originalsize.width < size.width) && (originalsize.height < size.height){
            return originalImage
        }else if (originalsize.width > size.width) && (originalsize.height > size.height){
            var rate: CGFloat = 1.0
            let widthRate = originalsize.width / size.width
            let heightRate = originalsize.height / size.height
            rate = widthRate > heightRate ? heightRate : widthRate
            var imgRef: CGImage
            var rect: CGRect
            if heightRate > widthRate{
                rect = CGRect(x: 0, y: originalsize.height/2-size.height*rate/2, width: originalsize.width, height: size.height*rate)
            }else{
                rect = CGRect(x: originalsize.width/2-size.width*rate/2, y: 0, width: size.width*rate, height: originalsize.height)
            }
            imgRef = (originalImage.cgImage?.cropping(to: rect))!
            UIGraphicsBeginImageContext(size)
            let ctx = UIGraphicsGetCurrentContext()
            ctx?.translateBy(x: 0, y: size.height)
            ctx?.scaleBy(x: 1.0, y: -1.0)
            ctx?.draw(imgRef, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let standardImage = UIGraphicsGetImageFromCurrentImageContext()
            print("改变后图片宽度\(standardImage?.size)")
            UIGraphicsEndImageContext()
            return standardImage!
        }else if (originalsize.height > size.height) || (originalsize.width > size.width){
            
            var imageRef: CGImage
            var rect: CGRect = .zero
            if originalsize.height > size.height{
                rect = CGRect(x: 0, y: originalsize.height/2 - size.height/2, width: originalsize.width, height: size.height)
            }else if originalsize.width > size.width{
                rect = CGRect(x: originalsize.width/2-size.width/2, y:0, width: size.width, height: originalsize.height)
            }
            imageRef = (originalImage.cgImage?.cropping(to: rect))!
            UIGraphicsBeginImageContext(size)
            let ctx = UIGraphicsGetCurrentContext()
            ctx?.translateBy(x: 0, y: size.height)
            ctx?.scaleBy(x: 1.0, y: -1.0)
            ctx?.draw(imageRef, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let standardImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return standardImage!
        }else{
            return originalImage
        }
        return originalImage
    }
}
