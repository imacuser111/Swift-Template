//
//  Item.swift
//  QPPNative
//
//  Created by user on 2021/12/17.
//

import Foundation
import RxDataSources

class Item: IdentifiableType, Equatable {
    typealias Identity = String
    
    var identity: Identity {
        return ""
    }
    
    var isPlaceholder: Bool = false
    
    
    /// 子類別需要復寫此方法。
    /// 不然默認為 identity 與 isPlaceholder 判斷。
    internal func isEqual(_ object: Any?) -> Bool {
        let i = toSelfObject(object)
        return identity == i?.identity && isPlaceholder == i?.isPlaceholder
    }
    
    /// 轉換成自己
    internal func toSelfObject(_ object: Any?) -> Self? {
        guard object != nil && type(of: object!) == Self.self else {
            return nil
        }
        return object as? Self
    }
    
    /// 不需要復寫
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.isEqual(rhs)
    }
}
