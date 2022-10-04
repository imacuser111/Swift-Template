//
//  TransitionViewController.swift
//  wanWatch
//
//  Created by user on 2022/3/17.
//

import Foundation
import UIKit
import RxSwift

protocol ReloadViewDelegate: AnyObject {
    func reloadView()
    func willTransition() // optional
}

extension ReloadViewDelegate {
    func reloadView() {}
    func willTransition() {}
}

/// 旋轉轉向專用viewcontroller，當有轉向變動時，會呼叫`delegate.reloadView`重刷該頁面。
/// Useage: 繼承`TransitionViewController`並 `reloadViewDelegate = self`
class TransitionViewController:UIViewController{
    
    private let transitionDisposeBag = DisposeBag()
    
    var viewWidth : CGFloat = kScreenWidth
    
    weak var reloadViewDelegate: ReloadViewDelegate?
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.reloadViewDelegate?.reloadView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        //Fix:https://stackoverflow.com/questions/34128339/traitcollectiondidchange-not-called-when-multitasking
        super.viewWillTransition(to: size, with: coordinator)
        
        reloadViewDelegate?.willTransition()
        
        coordinator.animate { content in
            
        } completion: { [weak self] coordinatorContext in
            self?.reloadViewDelegate?.reloadView()
        }
    }
    //
    private func setupNotification() {
        NotificationCenter.default.rx
            .notification(UIDevice.orientationDidChangeNotification)
            .take(until: self.rx.deallocated)
            .map({_ in return UIDevice.current.orientation})
            .filter({$0.isLandscape || $0.isPortrait})
            .distinctUntilChanged()
            .subscribe { [weak self] (notification) in
                guard let orientation = notification.element else {return}
                if UIDevice.current.userInterfaceIdiom != .pad{
                    return
                }
                if orientation.isLandscape{
                    self?.viewWidth = UIScreen.main.bounds.width
                    DispatchQueue.main.async {[weak self] in
                        self?.reloadViewDelegate?.reloadView()
                    }
                    
                    return
                } else if orientation.isPortrait{
                    self?.viewWidth = UIScreen.main.bounds.height
                    DispatchQueue.main.async {[weak self] in
                        self?.reloadViewDelegate?.reloadView()
                    }
                    return
                } else{
                    return
                }
            }.disposed(by:transitionDisposeBag)

        NotificationCenter.default.rx
            .notification(UIApplication.didBecomeActiveNotification)
            .take(until: self.rx.deallocated)
            .subscribe {[weak self] (notification) in
                DispatchQueue.main.async {[weak self] in
                    self?.reloadViewDelegate?.reloadView()
                }
            }.disposed(by:transitionDisposeBag)
    }
}
