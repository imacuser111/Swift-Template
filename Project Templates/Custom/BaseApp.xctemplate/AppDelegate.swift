//
//  AppDelegate.swift
//  Qpp
//
//  Created by 智陵 on 2022/9/19.
//

import UIKit
import Kingfisher


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    /// 修正 iOS 13 以下黑屏問題
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    var disposeBag = DisposeBag()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Kingfisher
        ImageCache.default.memoryStorage.config.totalCostLimit = 100 * 1024 * 1024
        ImageCache.default.memoryStorage.config.countLimit = 100
        // Limit disk cache size to 0.5 GB.
        ImageCache.default.diskStorage.config.sizeLimit = 500 * 1024 * 1024
        
        // version-init
//        setupCheckVersion()
        
        // iOS13 生成流程
        if #available(iOS 13.0, *) {
            // iOS 13 的設定會在 SceneDelegate 被執行
        } else {
            let window = UIWindow(frame: UIScreen.main.bounds)
            appCoordinator = AppCoordinator(window: window)
            appCoordinator?.start()
                .subscribe()
                .disposed(by: disposeBag)
        }
        
        // Override point for customization after application launch.
        return true
    }
    

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
//    // 設定轉向
//    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
//
//        // 支援轉向
//        if window?.rootViewController?.currentViewController?.canSupporTurn == true {
//            return [.landscape, .portrait]
//        }
//        return .portrait
//    }
}

