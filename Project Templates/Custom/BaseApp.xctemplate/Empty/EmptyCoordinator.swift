//
//  EmptyCoordinator.swift
//  Qpp
//
//  Created by mike on 2022/9/28.
//

import Foundation
import UIKit


// 測試用空入口
class EmptyCoordinator: BaseCoordinatorType<Void> {
    
    var coordinatorRootVC: UIViewController { navi }
    var type: TabType
    
    #warning("尚未設置WKNavigationController")
    private let navi = UINavigationController()
    private let viewController = EmptyViewController()
    
    
    init(type: TabType) {
    
        self.type = type
        
        super.init()
    }
    
    override func start() -> Observable<Void> {
        
        navi.tabBarItem = WKTabBarItem(type: type)
        navi.pushViewController(viewController, animated: false)
        
        return .never()
    }
}
