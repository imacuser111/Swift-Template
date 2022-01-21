//___FILEHEADER___

import UIKit
import RxSwift

// MARK: - Section(data)

class ___FILEBASENAMEASIDENTIFIER___: BaseCoordinator<Void> {
    
    private let rootViewController: UIViewController
    
    private var vc: <#UIViewController#>
    
    private var navi: WKNavigationController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        
        vc = <#UIViewController#>
        
        navi = WKNavigationController(rootViewController: vc)
        
        super.init()
    }
    
    deinit {
        print("deiniting \(self)")
    }
    
    override func start() -> Observable<Void> {
        navi.modalPresentationStyle = .overFullScreen
        
        navi.transitioningDelegate = self
        
        rootViewController.present(navi, animated: true, completion: nil)
        
        vc.backBtn.rx.tap.asObservable().bind(to: dismissTrigger).disposed(by: disposeBag)
        
        return dismissTrigger.take(1).do(onNext: { [weak self] _ in
            self?.navi.dismiss(animated: true, completion: nil)
        })
    }
}
