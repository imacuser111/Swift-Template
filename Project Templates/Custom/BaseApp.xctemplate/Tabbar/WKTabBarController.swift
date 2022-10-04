//
//  WKTabBarController.swift
//  Qpp
//
//  Created by mike on 2022/9/28.
//

import UIKit
import RxSwift


// tab 類型
enum TabType: Int {
    //我的最愛
    case myFavourite
    //背包
    case bag
    //掃描
    case scanning
    //討論
    case discussion
    //個人資訊
    case profileInfo

    
    //未選的image
    var image: UIImage {
        switch self {
        case .myFavourite:
            return getOriginalImage(named: .init())
            
        case .bag:
            return getOriginalImage(named: .init())
            
        case .scanning:
            return getOriginalImage(named: .init())
            
        case .discussion:
            return getOriginalImage(named: .init())
            
        case .profileInfo:
            return getOriginalImage(named: .init())
        }
    }
    
    
    //已選的image
    var selectedImage: UIImage {
        switch self {
        case .myFavourite:
            return getOriginalImage(named: .init())
            
        case .bag:
            return getOriginalImage(named: .init())
            
        case .scanning:
            return getOriginalImage(named: .init())
        
        case .discussion:
            return getOriginalImage(named: .init())
            
        case .profileInfo:
            return getOriginalImage(named: .init())
        }
    }
    
    
    //標題
    var title: String {
        switch self {
        case .myFavourite:
            return "trash"
            
        case .bag:
            return "trash"
            
        case .scanning:
            return "trash"
        
        case .discussion:
            return "trash"
            
        case .profileInfo:
            return "trash"
        }
    }
    
    // 取得 Tabbar 圖片
    private func getOriginalImage(named: String) -> UIImage {
        return UIImage(named: named)?.withRenderingMode(.alwaysOriginal) ?? UIImage()
    }
}

//MARK: WKTabBarItem
//自訂 UITabBarItem
class WKTabBarItem : UITabBarItem {
    
    var type : TabType
    
    
    init(type: TabType) {
        self.type = type
        super.init()
        self.update()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        self.title = type.title
        self.selectedImage = type.selectedImage
        self.image = type.image
    }
}


class WKTabBarController: UITabBarController {
    
    weak var coordinator: TabbarCoordinator?
    
    private let tabBarTintColor = UIColor.blue
    private let tabBarBackgroundColor = UIColor.blue
    
    private let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateColorBindings()
        self.updateImageBindings()
        self.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.selectedIndex = TabType.myFavourite.rawValue
    }
    
    private func updateColorBindings(){
        //MARK:Theme
        //color
//        UIColor.bgColor.observe(on: MainScheduler.instance).bind {[weak self] color in
//            self?.tabBar.barTintColor = color
//            if #available(iOS 15.0, *) {
//               let appearance = UITabBarAppearance()
//               appearance.configureWithOpaqueBackground()
//               appearance.backgroundColor = color
//               self?.tabBar.standardAppearance = appearance
//               self?.tabBar.scrollEdgeAppearance = appearance
//            }
//        }.disposed(by:disposeBag)
        
        // 文字顏色改成跟 Logo 一樣
        self.tabBar.tintColor = tabBarTintColor

        
        // TODO: for iOS 15, XCode 13 新專案有tabbar 透視問題
        // https://stackoverflow.com/questions/68688270/ios-15-uitabbarcontrollers-tabbar-background-color-turns-black
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = tabBarBackgroundColor // 設定 QPP 預設顏色
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        else {
            self.tabBar.isTranslucent = false
            self.tabBar.barTintColor = tabBarBackgroundColor
        }
        
//        self.tabBar.theme.tintColor = themed({$0.color.labelColor})
//        UIColor.secondarylabelcolor.observe(on: MainScheduler.instance).bind {[weak self] color in
//            self?.tabBar.unselectedItemTintColor = color
//        }.disposed(by:disposeBag)
    }
    
    private func updateImageBindings() {
        
        #warning("尚未設定ThemeService")
        //MARK:Theme
//        ThemeService.typeStream.bind { [weak self] _ in
//            guard let viewcontrollers = self?.viewControllers else { return }
//            for vc in viewcontrollers {
//                if let item = vc.tabBarItem as? WKTabBarItem {
//                    vc.tabBarItem = WKTabBarItem(type: item.type)
//                }
//            }
//        }.disposed(by: disposeBag)
    }
    
    /// 裝置設定變模式
    /// 當 iPhone 轉換到不同方向時就會通知此方法。
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        #warning("尚未設定ThemeService")
//        if #available(iOS 13.0, *) {
//            if UserDefaultsAdapter.deviceSetting == false {
//                return
//            }
//            if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
//
//                let isDarkMode = traitCollection.userInterfaceStyle == .dark
//                UserDefaultsAdapter.darkmode = isDarkMode
//                ThemeService.switchTheme(isDarkMode ? .dark : .light)
//            }
//        }
    }
}

//MARK: UITabBarControllerDelegate
extension WKTabBarController : UITabBarControllerDelegate {
    
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool{
//
//        if let item = viewController.tabBarItem as? WKTabBarItem {
//            #warning("DEMO modified Follow not pressed")
//
//
//            // 打通知給其他有按讚的頁面
//            NotificationCenter.default.post(name: .NT_tabbarSelect,
//                                            object: item.type,
//                                            userInfo: nil)
//        }
//
//        return true
//    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
//        #warning("DEMO modified Follow not pressed")
//        #if DEBUG
//
//        #else
//        if viewController is FollowViewController{
//            return
//        }
//        #endif
        
        self.coordinator?.currentTabType = TabType(rawValue: viewController.tabBarController?.selectedIndex ?? 0) ?? .myFavourite
    }
}
