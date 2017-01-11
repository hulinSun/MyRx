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
    class func asyncCacheImage(with images:[String]){
        
        let group = DispatchGroup()
        for imageUrl in images {
            group.enter()
            KingfisherManager.shared.downloader.downloadImage(with: URL(string: imageUrl, options: nil, progressBlock: nil, completionHandler: { (img, _, _, _) in
                guard let i = img else{return}
                let real = UIImage.handleImage(originalImage: i, size: CGSize(width: UIConst.screenWidth, height: UIConst.screenWidth))
                KingfisherManager.shared.cache.store(real, forKey: imageUrl + "handle")
                group.leave()
            })
        }
    }
}
