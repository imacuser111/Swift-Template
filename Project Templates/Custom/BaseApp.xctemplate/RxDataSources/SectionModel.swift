//
//  SectionModel.swift
//  QPPNative
//
//  Created by user on 2021/12/17.
//

import Foundation
import RxDataSources


protocol SectionModel: AnimatableSectionModelType {
    ///section的資料型態
    associatedtype SectionType: RawRepresentable
 
    //每個section的資料型態
    var model: SectionType { set get }
    
    var items: [Item] { set get }
    
}
