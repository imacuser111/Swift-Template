//
//  AppCoordinator.swift
//  NewTalk
//
//  Created by chu hua on 2020/8/5.
//

import Foundation
import UIKit
import RxCocoa
import CoreData

//coordinator source: https://uptech.team/blog/mvvm-coordinators-and-rxswift

class AppCoordinator: BaseCoordinatorType<Void> {
    
    var coordinatorRootVC: UIViewController { rootVC }
    
    private let window: UIWindow
    
    #warning("尚未設置WKNavigationController")
    let rootVC = UINavigationController()
    
    /// 是否已有置頂vc
    private var isShowTop = false
    
//    private let finishLoginResult = CDManager.userData ?? ServerPack.FinishLoginResult()
//
//    private var isFirstTime: Bool {
//        return !(finishLoginResult.hasAccountData || UserDefaultsAdapter.isGuest)
//    }
    
    /// 測試用
    #warning("只後需要補登入方式")
    private var isFirstTime: Bool = true
    
    
    init(window: UIWindow) {
        self.window = window
        super.init()
        self.bindings()
        NetWorkStatusManager.shared.start()
    }
    
    func bindings() {
        // TODO: - 先將NT的方法複製過來，有需求再打開製作
        //強版更
//        _ = NotificationCenter.default.rx
//            .notification(.NT_updateVersion)
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: {[weak self] _ in
//                guard let rvc = self?.rootVC else {return}
//                if self?.isShowTop == true{
//                    return
//                }
//                self?.isShowTop = true
//                if  let vc = rvc.currentViewController {
//
//                    vc.showWKConfirmAlert(description:Localization.string("contentUpdateForMandatory"), buttonConfirmTitle:Localization.string("btnNowUpdate")) {
//                        self?.isShowTop = false
//                        WKAnalytics.shared.recodeActionAnalytics(.actionGoToAppUpdateNow)
//                        let url = NSURL(string: StoreURL)
//                        UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
//                    }
//                }
//            }).disposed(by: disposeBag)
        
        //條款
//        _ = NotificationCenter.default.rx
//            .notification(.NT_termsVer)
//            .observe(on: MainScheduler.instance)
//            .flatMap { [weak self] info -> Observable<Void> in
//                guard let ver = info.userInfo?["ver"] as? Int else { return Observable.never() }
//                guard let rvc = self?.rootVC else { return Observable.never() }
//                if self?.isShowTop == true{
//                    return Observable.never()
//                }
//                self?.isShowTop = true
//                if  let vc = rvc.currentViewController {
//                    if vc is UpdateTermsViewController{
//                        return Observable.never()
//                    }
//                    let termsVC = UpdateTermsViewController(ver)
//                    let navi = WKNavigationController(rootViewController:termsVC)
//                    navi.modalPresentationStyle = .fullScreen
//                    vc.present(navi, animated: true, completion: nil)
//
//                    return termsVC.btn.rx.tap.asObservable()
//                }
//                return Observable.never()
//            }.subscribe { [weak self] _ in
//                self?.isShowTop = false
//            }.disposed(by: disposeBag)
        
        //提版更
//        _ = NotificationCenter.default.rx
//            .notification(.NT_remindVersion)
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: {[weak self] _ in
//                guard let rvc = self?.rootVC else {return}
//                if self?.isShowTop == true{
//                    return
//                }
//                self?.isShowTop = true
//                if let vc = rvc.currentViewController {
//                    let time = UserDefaultsAdapter.remindVersion
//                    if time == 0 || UserDefaultsAdapter.remindVersion < Int64(Date().timeIntervalSince1970){
//                        UserDefaultsAdapter.remindVersion = Int64(Date().timeIntervalSince1970) + 48 * 3600
//                        vc.showWKConfirmAndCancelAlert(description:Localization.string("contentUpdateForRemind"), buttonConfirmTitle:Localization.string("btnNowUpdate"), buttonCancelTitle: Localization.string("btnCancel")) {
//                            let url = NSURL(string: StoreURL)
//                            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
//                            WKAnalytics.shared.recodeActionAnalytics(.actionAgreeToUpdateTerms)
//                            self?.isShowTop = false
//                        } cancelBlock: {
//                            self?.isShowTop = false
//                            WKAnalytics.shared.recodeActionAnalytics(
//                                .actionDisagreeToUpdateTerms)
//                        }
//                    }
//
//                }
//            }).disposed(by: disposeBag)
        
        //系統維護
//        _ = NotificationCenter.default.rx
//            .notification(.NT_systemMainTain)
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: {[weak self] info in
//                if self?.isShowTop == true{
//                    return
//                }
//                self?.isShowTop = true
//                guard let msg = info.userInfo?["msg"] as? String else{return}
//                guard let rvc = self?.rootVC else {return}
//                if  let vc = rvc.currentViewController {
//                    let sVC = SystemMaintainViewController(msg)
//                    sVC.modalPresentationStyle = .fullScreen
//                    vc.present(sVC, animated: true, completion: nil)
//                }
//            }).disposed(by: disposeBag)
        
    }
    
    override func start() -> Observable<Void> {
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
        
        initTheme()
        return route(isFirstTimeUser: isFirstTime)
    }
    
    private func initTheme(){
      
        /// 設定黑暗模式
        if #available(iOS 13.0, *) {
            if UserDefaultsAdapter.deviceSetting == true {
                let isDark = UITraitCollection.current.userInterfaceStyle == .dark
                UserDefaultsAdapter.darkmode = isDark
            }
        }
        
        /// 設定主題
        self.updateTheme()
    }
    
    private func updateTheme() {
        #warning("尚未設定ThemeService")
//        ThemeService.switch(UserDefaultsAdapter.darkmode ? .dark : .light)
//
//        let list = LanguageList(rawValue: UserDefaultsAdapter.language) ?? .systemSetting
//        ThemeService.switchLangunage(list.language)
    }
    
    func route(isFirstTimeUser: Bool) -> Observable<Void> {

        let tabbarCoordinator = TabbarCoordinator(rootViewController: rootVC)
        return coordinate(to: tabbarCoordinator)
        
        
//        if isFirstTimeUser {
//            let login = LoginCoordinator(rootViewController: rootVC)
//            return coordinate(to: login).map { _ in () }
//        } else {
//
//            let tabbarCoordinator = TabbarCoordinator(rootViewController: rootVC)
////            functionCall.entry(type: .sysServ, acct: loginData.phoneNumber)
//            return coordinate(to: tabbarCoordinator)
//        }
    }
}

