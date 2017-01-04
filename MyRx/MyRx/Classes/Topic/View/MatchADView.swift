//
//  MatchADView.swift
//  MyRx
//
//  Created by Hony on 2017/1/4.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import Kingfisher

/// 火柴盒的广告轮播View
public class MatchADView<ImageType>: UIView , UIScrollViewDelegate{
    
     typealias ADDidClickClosure = (Int) -> Void
     typealias ADViewLoadImageClosure = (UIImageView,ImageType) -> Void
     var imageDidClick:ADDidClickClosure?
     var loadImage:ADViewLoadImageClosure?
     var images = [ImageType]() {
        didSet {
            pageControl.numberOfPages = images.count
            reloadData()
            removeTimer()
            if images.count > 1 { addTimer() }
        }
    }
    
    private func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
    private func addTimer() {
        guard  images.count > 0 else  {return;}
        timer = Timer(timeInterval: 2.5, target: self, selector: #selector(timerScrollImage), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoopMode.defaultRunLoopMode)
        RunLoop.current.run(mode: RunLoopMode.UITrackingRunLoopMode, before: Date())
    }
    
    fileprivate var currentImageArray = [ImageType]()
    fileprivate var currentPage = 0
    fileprivate var timer:Timer?
    
    fileprivate lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        scrollView.contentSize = CGSize(width: self.frame.width * 3, height: self.frame.height)
        scrollView.contentOffset = CGPoint(x: self.frame.width, y: 0)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    fileprivate lazy var pageControl:UIPageControl = {
        let pageWidth = self.frame.width * 0.25
        let pageHeight:CGFloat = 20.0
        let pageX = self.frame.width - pageWidth - 10.0
        let pageY = self.frame.height -  30.0
        let pageControl = UIPageControl(frame: CGRect(x: pageX, y: pageY, width: pageWidth, height: pageHeight))
        pageControl.isUserInteractionEnabled = false
        pageControl.hidesForSinglePage = true
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.pageIndicatorTintColor = .blue
        return pageControl
    }()
    
    @objc fileprivate func timerScrollImage() {
        reloadData()
        scrollView.setContentOffset(CGPoint(x: frame.width * 2.0 , y: 0) , animated: true)
    }
    override init (frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        addSubview(pageControl)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        scrollView.delegate = nil
        removeTimer()
    }
    
    fileprivate func reloadData() {
        
        //设置页数
        pageControl.currentPage = currentPage
        print("currentPage = \(currentPage)")
        //根据当前页取出图片
        getDisplayImagesWithCurpage()
        //从scrollView上移除所有的subview
        scrollView.subviews.forEach({$0.removeFromSuperview()})
        
        for i in 0..<3 {
            let frame = CGRect(x: self.frame.width * CGFloat(i), y: 0, width: self.frame.width, height: self.frame.height)
            let imageView = UIImageView(frame: frame)
            imageView.isUserInteractionEnabled = true
            imageView.clipsToBounds = true
            scrollView.addSubview(imageView)
            imageView.image = UIImage(named: "loading_Image")
            loadImage?(imageView,currentImageArray[i])
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapImage))
            imageView.addGestureRecognizer(tap)
        }
    }
    
    fileprivate func  getDisplayImagesWithCurpage() {
        //取出开头和末尾图片在图片数组里的下标
        var front = currentPage - 1
        var last = currentPage + 1
        //如果当前图片下标是0，则开头图片设置为图片数组的最后一个元素
        if currentPage == 0 {
            front = images.count - 1
        }
        //如果当前图片下标是图片数组最后一个元素，则设置末尾图片为图片数组的第一个元素
        if currentPage == images.count - 1 {
            last = 0
        }
        //如果当前图片数组不为空，则移除所有元素
        if currentImageArray.count > 0 {
            currentImageArray = [ImageType]()
        }
        //当前图片数组添加图片
        currentImageArray.append(images[front])
        currentImageArray.append(images[currentPage])
        currentImageArray.append(images[last])
    }
    
    @objc fileprivate func tapImage() {
        imageDidClick?(currentPage)
    }
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //如果scrollView当前偏移位置x大于等于两倍scrollView宽度
        if scrollView.contentOffset.x >= frame.width * 2.0 {
            //当前图片位置+1
            currentPage += 1
            //如果当前图片位置超过数组边界，则设置为0
            if currentPage == images.count {
                currentPage = 0
            }
            reloadData()
            //设置scrollView偏移位置
            scrollView.contentOffset = CGPoint(x: frame.width, y: 0)
        }else if scrollView.contentOffset.x <= 0.0{
            currentPage -= 1
            if currentPage == -1 {
                currentPage = images.count - 1
            }
            reloadData()
            //设置scrollView偏移位置
            scrollView.contentOffset = CGPoint(x: frame.width, y: 0)
        }
    }
    
    
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.setContentOffset(CGPoint(x: frame.width, y: 0), animated: true)
    }
    
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
}



 extension Reactive where Base: MatchADView<TopicBanner> {
    var banners: UIBindingObserver<Base, [TopicBanner]> {
        return UIBindingObserver(UIElement: base) { adView, _ in
            adView.loadImage = { ( imageView:UIImageView,imageName:TopicBanner) in
                imageView.kf.setImage(with: URL(string: imageName.thumb!), placeholder: UIImage(named: "loading_Image"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
    }
}
