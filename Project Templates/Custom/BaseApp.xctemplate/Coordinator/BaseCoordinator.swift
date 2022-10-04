//
//  BaseCoordinator.swift
//  NewTalk
//
//  Created by hsu tzu Hsuan on 2020/9/28.
//

import Foundation
import UIKit
import RxRelay

@_exported import RxSwift

protocol BaseCoordinatorProtocol {
    var coordinatorRootVC: UIViewController { get }
}

typealias BaseCoordinatorType<T> = BaseCoordinator<T> & BaseCoordinatorProtocol

// base abstract coordinator generic over then return type of 'start' method
class BaseCoordinator<ResultType>: NSObject, UIViewControllerTransitioningDelegate {
    typealias CoordinationResult = ResultType
    
    let disposeBag = DisposeBag()
    
    let dismissTrigger = PublishRelay<ResultType>()
    
    private let identifier = UUID()
    
    private var childCoordinators = [UUID : Any]()
    
    /// store coordinator to the 'childcoordinators' dictionary
    private func store<T>(coordinator: BaseCoordinatorType<T>) {
        // TODO: - 因 playerCoordinator 是由另一個 windows 開起，但 push 時需要尋找 keyWindow 的 lastCorrdinator，所以 playerCoordinator 不能存在 childCoordinators 中
//        if coordinator is PlayerCoordinator { return }
        childCoordinators[coordinator.identifier] = coordinator
    }
    
    /// release coordinator from the 'childcoordinators' dictionary
    private func free<T>(coordinator: BaseCoordinatorType<T>) {
        childCoordinators[coordinator.identifier] = nil
    }
    
    func coordinate<T>(to coordinator: BaseCoordinatorType<T>) -> Observable<T> {
        store(coordinator: coordinator)
        return coordinator.start()
            .do(onNext: { [weak self] _ in self?.free(coordinator: coordinator)})
    }
    
    func start() -> Observable<ResultType> {
        fatalError("start method shoulb be implemented")
    }
    
//    func lastCoordinator(coordinator: BaseCoordinatorType<ResultType>) -> BaseCoordinatorType<ResultType> {
//        if let childCoordinator = coordinator.childCoordinators.first?.value as? BaseCoordinatorType<ResultType> {
//            if let tabBarCoordinator = childCoordinator as? TabbarCoordinator {
//                if let currentCoordinator = tabBarCoordinator.currentCoordinator as? BaseCoordinatorType<ResultType> {
//                    return lastCoordinator(coordinator: currentCoordinator)
//                }
//            }
//            return lastCoordinator(coordinator: childCoordinator)
//        }
//        return coordinator
//    }
    
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = WKPresentTransition()
        return transition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = WKDismissPresentTransition()
        return transition
    }
}
