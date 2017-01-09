////
////  Raduis.swift
////  MyRx
////
////  Created by Hony on 2017/1/9.
////  Copyright © 2017年 Hony. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//private func roundbyunit(_ num: Double,  _ unit: inout Double) -> Double {
//    let remain = modf(num, &unit)
//    if (remain > unit / 2.0) {
//        return ceilbyunit(num, &unit)
//    } else {
//        return floorbyunit(num, &unit)
//    }
//}
//private func ceilbyunit(_ num: Double,  _ unit: inout Double) -> Double {
//    return num - modf(num, &unit) + unit
//}
//
//private func floorbyunit(_ num: Double,  _ unit: inout Double) -> Double {
//    return num - modf(num, &unit)
//}
//
//private func pixel(num: Double) -> Double {
//    var unit: Double
//    switch Int(UIScreen.main.scale) {
//    case 1: unit = 1.0 / 1.0
//    case 2: unit = 1.0 / 2.0
//    case 3: unit = 1.0 / 3.0
//    default: unit = 0.0
//    }
//    return roundbyunit(num, &unit)
//}
//
//extension UIView {
//    
//    func kt_addCorner(radius: CGFloat) {
//        self.kt_addCorner(radius: radius, borderWidth: 1, backgroundColor: UIColor.clear, borderColor: UIColor.black)
//    }
//    
//    func kt_addCorner( radius: CGFloat,
//                      borderWidth: CGFloat,
//                      backgroundColor: UIColor,
//                      borderColor: UIColor) {
//        let imageView = UIImageView(image: kt_drawRectWithRoundedCorner(radius: radius,
//                                                                        borderWidth: borderWidth,
//                                                                        backgroundColor: backgroundColor,
//                                                                        borderColor: borderColor))
//        self.insertSubview(imageView, at: 0)
//    }
//    
//    func kt_drawRectWithRoundedCorner( radius: CGFloat,
//                                      borderWidth: CGFloat,
//                                      backgroundColor: UIColor,
//                                      borderColor: UIColor) -> UIImage {
//        
//        let sizeToFit = CGSize(width: pixel(num: Double(self.bounds.size.width)), height: Double(self.bounds.size.height))
//        let halfBorderWidth = CGFloat(borderWidth / 2.0)
//        
//        UIGraphicsBeginImageContextWithOptions(sizeToFit, false, UIScreen.main.scale)
//        let context = UIGraphicsGetCurrentContext()
//        
//        context?.setLineWidth(borderWidth)
//        context?.setStrokeColor(borderColor.cgColor)
//        context?.setFillColor(backgroundColor.cgColor)
//        
//        let width = sizeToFit.width, height = sizeToFit.height
//        // 开始坐标右边开始
//        context?.move(to: CGPoint(x: width - halfBorderWidth, y: radius + halfBorderWidth))
//        context?.addArc(center: <#T##CGPoint#>, radius: <#T##CGFloat#>, startAngle: <#T##CGFloat#>, endAngle: <#T##CGFloat#>, clockwise: <#T##Bool#>)
//        
//        CGContextAddArcToPoint(context, width - halfBorderWidth, height - halfBorderWidth, width - radius - halfBorderWidth, height - halfBorderWidth, radius)  // 右下角角度
//        CGContextAddArcToPoint(context, halfBorderWidth, height - halfBorderWidth, halfBorderWidth, height - radius - halfBorderWidth, radius) // 左下角角度
//        CGContextAddArcToPoint(context, halfBorderWidth, halfBorderWidth, width - halfBorderWidth, halfBorderWidth, radius) // 左上角
//        CGContextAddArcToPoint(context, width - halfBorderWidth, halfBorderWidth, width - halfBorderWidth, radius + halfBorderWidth, radius) // 右上角
//        
//        CGContextDrawPath(UIGraphicsGetCurrentContext(), .FillStroke)
//        let output = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return output
//    }
//}
//
//extension UIImageView {
//    /**
//     / !!!只有当 imageView 不为nil 时，调用此方法才有效果
//     
//     :param: radius 圆角半径
//     */
//    override func kt_addCorner(radius radius: CGFloat) {
//        // 被注释的是图片添加圆角的 OC 写法
//        //        self.image = self.image?.imageAddCornerWithRadius(radius, andSize: self.bounds.size)
//        self.image = self.image?.kt_drawRectWithRoundedCorner(radius: radius, self.bounds.size)
//    }
//}
//
//extension UIImage {
//    func kt_drawRectWithRoundedCorner(radius radius: CGFloat, _ sizetoFit: CGSize) -> UIImage {
//        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: sizetoFit)
//        
//        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.mainScreen().scale)
//        CGContextAddPath(UIGraphicsGetCurrentContext(),
//                         UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner.AllCorners,
//                                      cornerRadii: CGSize(width: radius, height: radius)).CGPath)
//        CGContextClip(UIGraphicsGetCurrentContext())
//        
//        self.drawInRect(rect)
//        CGContextDrawPath(UIGraphicsGetCurrentContext(), .FillStroke)
//        let output = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        return output
//    }
//}
