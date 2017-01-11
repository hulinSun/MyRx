//
//  MatchDrawImageTool.swift
//  MyRx
//
//  Created by Hony on 2017/1/11.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import Kingfisher

/// 异步绘图
class MatchDrawImageTool: NSObject {
    class func asyncCacheImage(with topics:[Topic?]){
        
        let group = DispatchGroup()
        for case let tp? in topics{
            group.enter()
            KingfisherManager.shared.downloader.downloadImage(with: URL(string: (tp.info?.link_url)!)!, options: nil, progressBlock: nil, completionHandler: { (img, _, _, _) in
                // 下载好的图片
                guard let i = img else{return}
                let real = UIImage.handleImage(originalImage: i, size: CGSize(width: UIConst.screenWidth, height: UIConst.screenWidth))
//                tp.info?.link_url +"real"
                KingfisherManager.shared.cache.store(real, forKey: "--")
                group.leave()
            })
        }
    }
}
