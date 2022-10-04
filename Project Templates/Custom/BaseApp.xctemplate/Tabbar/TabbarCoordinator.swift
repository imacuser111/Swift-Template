//
//  TabbarCoordinator.swift
//  Qpp
//
//  Created by mike on 2022/9/28.
//

import Foundation
import UIKit
import RxRelay

// tabbar 入口
class TabbarCoordinator: BaseCoordinatorType<Void> {
    
    var coordinatorRootVC: UIViewController { rootViewController }
    var currentTabType: TabType = .myFavourite
    
    #warning("需要補其他 TabbarCoordinator")
    var currentCoordinator: BaseCoordinator<Void> {
        switch currentTabType {
        case .myFavourite:
            return myFavouriteCoordinator
        case .bag:
            return bagCoordinator
        case .scanning:
            return scanningCoordinator
        case .discussion:
            return discussionCoordinator
        case .profileInfo:
            return profileInfoCoordinator
        }
    }
    
    // 我的最愛
    private var myFavouriteCoordinator = EmptyCoordinator(type: .myFavourite)
    // 背包
    private var bagCoordinator = EmptyCoordinator(type: .bag)
    // 掃描
    private var scanningCoordinator = EmptyCoordinator(type: .scanning)
    // 討論區
    private var discussionCoordinator = EmptyCoordinator(type: .discussion)
    // 個人資訊
    private var profileInfoCoordinator = EmptyCoordinator(type: .profileInfo)
    
    
    let tabBarController = WKTabBarController()
    
    private let rootViewController: UIViewController
    private let defaultTab: TabType
    
    
    init(rootViewController: UIViewController, defaultTab: TabType = .myFavourite) {
        self.rootViewController = rootViewController
        self.defaultTab = defaultTab
        super.init()
    }
    
    override func start() -> Observable<Void> {

        tabBarController.coordinator = self
        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.viewControllers = [
            myFavouriteCoordinator.coordinatorRootVC,
            bagCoordinator.coordinatorRootVC,
            scanningCoordinator.coordinatorRootVC,
            discussionCoordinator.coordinatorRootVC,
            profileInfoCoordinator.coordinatorRootVC
        ]

        self.rootViewController.present(tabBarController, animated: false) { [weak self] in
            if self?.defaultTab != .myFavourite {
                self?.tabBarController.selectedIndex = self?.defaultTab.rawValue ?? TabType.myFavourite.rawValue
            }
        }

        return Observable.merge(
            coordinate(to: myFavouriteCoordinator),
            coordinate(to: bagCoordinator),
            coordinate(to: scanningCoordinator),
            coordinate(to: discussionCoordinator),
            coordinate(to: profileInfoCoordinator)
        )
    }
}

