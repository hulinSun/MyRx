//
//  BoxMusicCell.swift
//  MyRx
//
//  Created by Hony on 2017/1/12.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import Kingfisher
import RxCocoa
import RxSwift

class BoxMusicCell: UICollectionViewCell {
    
    @IBOutlet weak var retBtn: UIButton!
    @IBOutlet weak var zanBtn: UIButton!
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    var btnClick: BtnClick?
    
    @IBOutlet weak var imgView: UIImageView!{
        didSet{
            imgView.layer.cornerRadius = 2
            imgView.clipsToBounds = true
        }
    }
    
    typealias BtnClick = ()-> Void
    override func awakeFromNib() {
        super.awakeFromNib()
        
        playBtn.addTarget(self, action: #selector(playBtnClick), for: .touchUpInside)
    }
    
    func playBtnClick()  {
        playBtn.isSelected = !playBtn.isSelected
        // 回调
        btnClick?()
    }
    
    
    func config(with data: Music)  {
 
        self.memoLabel.text = data.infos?.author ?? "😝"
        self.nameLabel.text = data.infos?.title ?? "😝"
        self.zanBtn.setTitle(data.infos?.heart ?? "😝", for: .normal)
        self.retBtn.setTitle(data.infos?.forward ?? "😝", for: .normal)
        if let org = data.infos?.thumb {
            self.imgView.image = KingfisherManager.shared.cache.retrieveImageInMemoryCache(forKey: org + "handle")
        }
    }
    
    
}
