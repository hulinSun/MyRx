//
//  MatchViewController.swift
//  MyRx
//
//  Created by Hony on 2016/12/29.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Moya

/// 首页的火柴控制器
class MatchViewController: UIViewController {

    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let provider = RxMoyaProvider<MatchService>()
        provider.request(.likemomentsad).subscribe { (e) in
//            guard let response = e.element else { return }
//            if let m = response.mapObject(<#T##type: T.Type##T.Type#>){
//            }
            print(e)
        }.addDisposableTo(bag)
        
        let s = Bundle.main.path(forResource: "momentsad", ofType: nil)
        
        if let data = try? Data(contentsOf: URL(fileURLWithPath: s!)){
            if let str = String(data: data, encoding: .utf8){
                print(str)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
