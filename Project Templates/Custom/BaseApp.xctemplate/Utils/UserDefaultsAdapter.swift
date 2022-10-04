//
//  UserDefaultAdapter.swift
//  NewTalk
//
//  Created by chu hua on 2020/8/6.
//

import Foundation
import UIKit


let appGroupIdentifier = "group.pacify.qpp"
@propertyWrapper struct UserDefaultsBacked<Value> {
    let key: String
    let defaultValue: Value
    var storage: UserDefaults = UserDefaults.init(suiteName: appGroupIdentifier) ?? .standard
    
  var wrappedValue: Value {
        get {
            let value = storage.value(forKey: key) as? Value
//            print("key:\(key) value:\(value ?? defaultValue)")
            return value ?? defaultValue
        }
        set {
            storage.setValue(newValue, forKey: key)
        }
    }
}

struct UserDefaultsAdapter {
    private static let LANGUAGE = "LANGUAGE"
    private static let DARK_MODE = "DARKMODE"
    private static let DEVICE_SETTING = "DEVICESETTING" // 使用裝置設定
    private static let UUID = "UUID" // User UUID
    private static let FIREBASEID = "FIREBASEID" // firebaseID(for notification token)
    private static let TERMSVER = "TERMSVER" // 條款變更
    private static let ISGUSET = "ISGUSET" // 是否為訪客
    private static let ISFIRSTVIDEOCOMMENT = "ISFIRSTVIDEOCOMMENT" // 是否第一次開啟留言(show tip資料)
    private static let VIDEOSEARCHRECORD = "VIDEOSEARCHRECORD" // 影片搜尋紀錄
    private static let CREATORSEARCHRECORD = "CREATORSEARCHRECORD" // 創作者搜尋紀錄
    
    /// 語系設定
//    @UserDefaultsBacked<String>(key: LANGUAGE, defaultValue: LanguageList.systemSetting.rawValue) static var language: String
    
    /// 深色模式
    @UserDefaultsBacked<Bool>(key: DARK_MODE, defaultValue: false) static var darkmode: Bool
    
    /// 裝置設定(for ios 13 or later)
    @UserDefaultsBacked<Bool>(key: DEVICE_SETTING, defaultValue: true) static var deviceSetting: Bool
    
    /// User UUID
    @UserDefaultsBacked<String>(key: UUID, defaultValue: "") static var userUUID: String
    
    /// User termsVer
    @UserDefaultsBacked<Int>(key: TERMSVER, defaultValue: -1) static var termsVer: Int
    
    /// 是否為訪客
    @UserDefaultsBacked<Bool>(key: ISGUSET, defaultValue: false) static var isGuest: Bool
    
    /// 是否第一次開啟留言(show tip資料)
    @UserDefaultsBacked<Bool>(key: ISFIRSTVIDEOCOMMENT, defaultValue: true) static var isFirstVideoContent: Bool
    
    /// 影片搜尋紀錄
    @UserDefaultsBacked<[String]>(key: VIDEOSEARCHRECORD, defaultValue: []) static var videoSearchRecord: [String]
    
    /// 創作者搜尋紀錄
    @UserDefaultsBacked<[String]>(key: CREATORSEARCHRECORD, defaultValue: []) static var creatorSearchRecord: [String]
}
