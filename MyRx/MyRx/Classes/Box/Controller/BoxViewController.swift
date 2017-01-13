//
//  BoxViewController.swift
//  MyRx
//
//  Created by Hony on 2016/12/29.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import ReusableKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources



/// 盒子控制器
class BoxViewController: UIViewController {
    
   private class BoxLayout: UICollectionViewFlowLayout {
        override func prepare() {
            super.prepare()
            self.itemSize = CGSize(width: UIConst.screenWidth, height: UIConst.screenHeight - 64 - 49)
            self.scrollDirection = .horizontal
            self.minimumLineSpacing = 0
            self.minimumInteritemSpacing = 0
        }
    }
    
    // MARK: 这个播放器需要持有。不然会被释放。那么久不会播放音乐了
    var musicPlayer: MusicPlayer!
    
    struct Reuse {
        static let musicCell = ReusableCell<BoxMusicCell>(nibName: "BoxMusicCell")
    }
    
    
    fileprivate lazy var collectionView: UICollectionView = {
        let rect = CGRect(x: 0, y: 64, width: UIConst.screenWidth, height: UIConst.screenHeight - 64 - 49)
        let i = UICollectionView(frame: rect, collectionViewLayout: BoxLayout())
        i.register(Reuse.musicCell)
        i.showsVerticalScrollIndicator = false
        i.showsHorizontalScrollIndicator = false
        i.isPagingEnabled = true
        return i
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "柴扉"
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        setupData()
    }

    /// 简单样式
    var easyDatas = Variable([Music]())
    
    private func setupData(){
        
        HttpService.getHomeMusic { [unowned self] (e) in
            let musics = e.map{$0.infos?.thumb}.flatMap{$0}
            let imageSize = CGSize(width: UIConst.screenWidth - CGFloat(2 * 18), height:  CGFloat(390))
            MatchDrawImageTool.asyncCacheImage(with: musics, size: imageSize, callback: {
                self.easyDatas.value = e
                _ = self.easyDatas.asObservable().bindTo(self.collectionView.rx.items(cellIdentifier: "BoxMusicCell", cellType: BoxMusicCell.self)){ row, music , cell in
                    cell.config(with: music)
                    cell.btnClick = {
                        self.musicPlayer = MusicPlayer(musics: e, index: 2)
                    }
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
