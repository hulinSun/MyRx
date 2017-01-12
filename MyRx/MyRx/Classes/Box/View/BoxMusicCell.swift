//
//  BoxMusicCell.swift
//  MyRx
//
//  Created by Hony on 2017/1/12.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import Kingfisher

class BoxMusicCell: UICollectionViewCell {
    
    
    @IBOutlet weak var retBtn: UIButton!
    @IBOutlet weak var zanBtn: UIButton!
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!{
        didSet{
            imgView.layer.cornerRadius = 2
            imgView.clipsToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func config(with data: Music)  {
        self.memoLabel.text = data.infos?.author ?? "😝"
        self.nameLabel.text = data.infos?.title ?? "😝"
        
        if let org = data.infos?.thumb {
            self.imgView.image = KingfisherManager.shared.cache.retrieveImageInMemoryCache(forKey: org + "handle")
        }
    }
}
