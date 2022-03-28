//___FILEHEADER___

import Foundation
import UIKit

// MARK: - Section(data)

struct ___FILEBASENAMEASIDENTIFIER___: SectionModel {
    
    var model: SectionType
    
    // in Sections all Item
    var items: [Item]
    
    // uniquale identifier for identity
    fileprivate var identifier: String
    
    var identity: String {
        return identifier
    }
    
    /// section init(Not change this)
    /// - Parameters:
    ///   - original: when get datasource that call func
    ///   - items: sections's Array
    init(original: ___FILEBASENAMEASIDENTIFIER___, items: [Item]) {
        self = original
        self.items = items
    }
    
    /// init NewsSectionModel
    /// - Parameters:
    ///   - type: section Type
    ///   - items:
    init(model: SectionType, items: [Item], identifier: String? = nil) {
        self.items = items
        self.model = model
        self.identifier = identifier == nil ? model.rawValue : identifier ?? ""
    }
}

// MARK: - SctionType(欄位名稱)

extension ___FILEBASENAMEASIDENTIFIER___ {
    
    // 自定義SectionType
    enum SectionType: String, CaseIterable {
        case <#case#>
    }
}


// MARK: - CreateSection

extension ___FILEBASENAMEASIDENTIFIER___ {
    /// 設定列表
    /// - Returns: 設定列表
    static func section() -> [___FILEBASENAMEASIDENTIFIER___] {
        return [<#___FILEBASENAMEASIDENTIFIER___#>]
    }
}
