//
//  Observer+Schel.swift
//  MyRx
//
//  Created by Hony on 2016/12/30.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import RxSwift

public enum RxScheduler {
    case main
    case operation(OperationQueue)
    case serial(DispatchQoS.QoSClass)
    case concurrent(DispatchQoS.QoSClass)
    
    public func scheduler() -> ImmediateSchedulerType {
        switch self {
        case .main:
            return MainScheduler.instance
        case .serial(let QOS):
           return SerialDispatchQueueScheduler(qos: DispatchQoS(qosClass: QOS, relativePriority: 0))
        case .concurrent(let QOS):
            return ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: QOS, relativePriority: 0))
        case .operation(let queue):
            return OperationQueueScheduler(operationQueue: queue)
        }
    }
}

extension ObservableType {
    
    public func observeOn(_ scheduler: RxScheduler) -> RxSwift.Observable<Self.E> {
        return observeOn(scheduler.scheduler())
    }
    
    public func subscribeOn(_ scheduler: RxScheduler) -> RxSwift.Observable<Self.E> {
        return subscribeOn(scheduler.scheduler())
    }
    
}
