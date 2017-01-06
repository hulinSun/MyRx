//
//  MatchTopicFrameModel.swift
//  MyRx
//
//  Created by Hony on 2017/1/6.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit

class MatchTopicFrameModel {
    
    var topic: Topic{
        didSet{
            
            let margin: CGFloat = 10
            // 判断类型
            if topic.type == "tr" { // 推荐
                recomFrame = CGRect(x: margin, y: margin, width: 200, height: 20)
                topFrame = CGRect(x: 0, y: recomFrame.maxY, width: UIConst.screenWidth, height: 128)
            }else if topic.type == "th"{ // 正常
                recomFrame = CGRect.zero
                topFrame = CGRect(x: 0, y: 0, width: UIConst.screenWidth, height: 128)
            }
            
            // 判断是否有图片
            if (topic.info?.thumb?.contains("http"))!{ // 有图片
                photoFrame = CGRect(x: 0, y: topFrame.maxY, width: UIConst.screenWidth, height: UIConst.screenWidth)
                
                // 判断是否有文字
                if (topic.info?.content?.characters.count)! > 1 { // 有文字
                    // 计算文字
                    let str = (topic.info?.content)!.replacingOccurrences(of: "<br>", with: "\n")
                   let strSize = attrStringSize(string: str, font: UIFont.systemFont(ofSize: 14), lineSpace: 8)
                    
                    descFrame = CGRect(x: margin, y: photoFrame.maxY, width: UIConst.screenWidth - 2 * margin, height: strSize.height)
                    
                    bottomFrame = CGRect(x: 0, y: descFrame.maxY, width: UIConst.screenWidth, height: 50)
                    
                }else{ // 没有文字
                    descFrame = .zero
                    bottomFrame = CGRect(x: 0, y: photoFrame.maxY, width: UIConst.screenWidth, height: 50)
                }
            }else{ // 没有图片
                photoFrame = .zero
                
                // 判断是否有文字
                if (topic.info?.content?.characters.count)! > 1 { // 有文字
                    // 计算文字
                    let str = (topic.info?.content)!.replacingOccurrences(of: "<br>", with: "\n")
                    let strSize = attrStringSize(string: str, font: UIFont.systemFont(ofSize: 14), lineSpace: 8)
                    
                    descFrame = CGRect(x: margin, y: topFrame.maxY, width: UIConst.screenWidth - 2 * margin, height: strSize.height)
                    
                    bottomFrame = CGRect(x: 0, y: descFrame.maxY, width: UIConst.screenWidth, height: 50)
                    
                }else{ // 没有文字
                    descFrame = .zero
                    bottomFrame = CGRect(x: 0, y: topFrame.maxY, width: UIConst.screenWidth, height: 50)
                }
            }
            
            cellHeight = bottomFrame.maxY + margin
        }
    }
    
    
    /// 推荐
    private(set) var recomFrame: CGRect!
    
    /// 头部
    private(set) var topFrame: CGRect!
    
    /// 图片
    private(set) var photoFrame: CGRect!
    
    /// 描述
    private(set) var descFrame: CGRect!
    
    /// 底部
    private(set) var bottomFrame: CGRect!
    
    /// cell 高度
    private(set) var cellHeight: CGFloat!
    
    init(topic: Topic) {
        self.topic = topic
    }
    
    private func attrStringSize( string: String,  font: UIFont, lineSpace: CGFloat) ->CGSize{
        let prar = NSMutableParagraphStyle()
        prar.lineSpacing = lineSpace
        let attr = [NSFontAttributeName: font,NSParagraphStyleAttributeName : prar]
        let attStr = NSMutableAttributedString(string: string, attributes: attr)
        
        // 高度
        let strSize = attStr.boundingRect(with:
            CGSize(width: UIConst.screenWidth - 20, height: 10000), options: .usesLineFragmentOrigin, context: nil).size
        
        return strSize
    }
}
