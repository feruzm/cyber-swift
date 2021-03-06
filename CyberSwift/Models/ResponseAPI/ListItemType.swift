//
//  ListItemType.swift
//  Commun
//
//  Created by Chung Tran on 10/23/19.
//  Copyright © 2019 Commun Limited. All rights reserved.
//

import Foundation
import RxDataSources
import RxSwift

public protocol ListItemType: Decodable, Equatable, IdentifiableType {
    func newUpdatedItem(from item: Self) -> Self?
}
public extension ListItemType {
    static var changedEventName: String {"DidChange"}
    static var deletedEventName: String {"Deleted"}
    static var blockedEventName: String {"Blocked"}
    
    func notifyEvent(eventName: String, object: Any? = nil) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "\(Self.self)\(eventName)"), object: object ?? self)
    }
    
    func notifyChanged() {
        notifyEvent(eventName: Self.changedEventName)
    }
    
    func notifyDeleted() {
        notifyEvent(eventName: Self.deletedEventName)
    }
    
    static func observeEvent(eventName: String) -> Observable<Self> {
        NotificationCenter.default.rx.notification(.init(rawValue: "\(Self.self)\(eventName)"))
            .filter { notification in
                guard (notification.object as? Self) != nil
                    else {return false}
                return true
            }
            .map {$0.object as! Self}
            .observeOn(MainScheduler.instance)
    }
    
    static func observeItemChanged() -> Observable<Self> {
        observeEvent(eventName: changedEventName)
    }
    
    static func observeItemDeleted() -> Observable<Self> {
        observeEvent(eventName: deletedEventName)
    }
}

public protocol CachedHeightItemType: ListItemType {
    var height: CGFloat? {get set}
}

public extension CachedHeightItemType {
    static var heightChangedEventName: String {"HeightDidChange"}
    func heightDidChange(newHeight: CGFloat) {
        var item = self
        item.height = newHeight
        item.notifyChanged()
    }
    
    static func height(of item: Self.Identity, didChangeTo newHeight: CGFloat) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "\(Self.self)\(heightChangedEventName)"), object: [item: newHeight])
    }
    
    static func observeItemHeightChanged() -> Observable<([Self.Identity: CGFloat])> {
        NotificationCenter.default.rx.notification(.init(rawValue: "\(Self.self)\(heightChangedEventName)"))
            .filter { notification in
                guard (notification.object as? [Self.Identity: CGFloat]) != nil
                    else {return false}
                return true
            }
            .map {$0.object as! [Self.Identity: CGFloat]}
            .observeOn(MainScheduler.instance)
    }
}
