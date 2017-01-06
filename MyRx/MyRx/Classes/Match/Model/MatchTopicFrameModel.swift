//
//  MatchTopicFrameModel.swift
//  MyRx
//
//  Created by Hony on 2017/1/6.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit

class MatchTopicFrameModel {
    
    /// 在初始化方法中设置topic 。不会走didSet 方法
    var topic: Topic{
        didSet{
            
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
        if topic.type == "tr" || topic.type == "th"{
            caluateFrames(with: topic)
        }
    }
    
    private func caluateFrames(with topic: Topic){
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
        if let pic = topic.info?.thumb_org , pic.contains("http") { // 有图片的可能
            
            photoFrame = CGRect(x: 0, y: topFrame.maxY, width: UIConst.screenWidth, height: UIConst.screenWidth)
            
            // 判断是否有文字
            if let cot = topic.info?.content , cot.characters.count > 1{
                // 计算文字
                let str = (topic.info?.content)!.replacingOccurrences(of: "<br>", with: "\n")
                let strSize = attrStringSize(string: str, font: UIFont.systemFont(ofSize: 15), lineSpace: 8)
                
                descFrame = CGRect(x: margin * 1.5, y: photoFrame.maxY + margin, width: UIConst.screenWidth - 2 * margin, height: strSize.height)
                
                bottomFrame = CGRect(x: 0, y: descFrame.maxY, width: UIConst.screenWidth, height: 50)
                
            }else{ // 没有文字
                descFrame = .zero
                bottomFrame = CGRect(x: 0, y: photoFrame.maxY, width: UIConst.screenWidth, height: 50)
            }
            
        }else{ // 没图片
            photoFrame = .zero
            if let cot = topic.info?.content ,  cot.characters.count > 1 {
                // 计算文字
                let str = cot.replacingOccurrences(of: "<br>", with: "\n")
                let strSize = attrStringSize(string: str, font: UIFont.systemFont(ofSize: 15), lineSpace: 8)
                
                descFrame = CGRect(x: margin * 1.5, y: topFrame.maxY, width: UIConst.screenWidth - 2 * margin, height: strSize.height)
                bottomFrame = CGRect(x: 0, y: descFrame.maxY + margin, width: UIConst.screenWidth, height: 50)
            }else{ // 没有文字
                descFrame = .zero
                bottomFrame = CGRect(x: 0, y: topFrame.maxY, width: UIConst.screenWidth, height: 50)
            }
        }
        
        cellHeight = bottomFrame.maxY
    }
    
    private func attrStringSize( string: String,  font: UIFont, lineSpace: CGFloat) ->CGSize{
        let prar = NSMutableParagraphStyle()
        prar.lineSpacing = lineSpace
        let attr = [NSFontAttributeName: font,NSParagraphStyleAttributeName : prar]
        let attStr = NSMutableAttributedString(string: string, attributes: attr)
        
        // 高度
        let strSize = attStr.boundingRect(with:
            CGSize(width: UIConst.screenWidth - 30, height: 10000), options: .usesLineFragmentOrigin, context: nil).size
        
        return strSize
    }
}
