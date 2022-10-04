//
//  NetWorkStatusManager.swift
//  NewTalk
//
//  Created by Hsu on 2020/4/21.
//  https://github.com/neoighodaro/Handling-internet-connection-reachability-in-Swift

import Foundation
import Reachability
import RxRelay

class NetWorkStatusManager:NSObject{
    
    static let networkIsReachable = NSNotification.Name("networkIsReachable")
    
    static let networkIsUnreachable = NSNotification.Name("networkIsUnreachable")
    
    var reachability: Reachability!
    
    static let shared: NetWorkStatusManager = {
        return NetWorkStatusManager()
    }()
    
    override init() {
        super.init()
        do {
            reachability = try Reachability()
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(networkStatusChanged(_:)),
                name: .reachabilityChanged,
                object: reachability
            )
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        // Do something globally here!
//        print("networkStatus")
        switch (NetWorkStatusManager.shared.reachability).connection {
        case .none:fallthrough
        case .unavailable:
            NetWorkStatusManager.connectWork.accept(false)
             NotificationCenter.default.post(name: NetWorkStatusManager.networkIsUnreachable, object: nil)
        case .wifi:fallthrough
        case .cellular:
            NetWorkStatusManager.connectWork.accept(true)
            NotificationCenter.default.post(name: NetWorkStatusManager.networkIsReachable, object: nil)
        }
    }
    
    func start(){
    }
    
    static func stopNotifier() -> Void {
        do {
            // Stop the network status notifier
            try (NetWorkStatusManager.shared.reachability).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }
    
    // Network is reachable
    static func isReachable(completed: @escaping (NetWorkStatusManager) -> Void) {
        if (NetWorkStatusManager.shared.reachability).connection != .unavailable { completed(NetWorkStatusManager.shared)
        }
    }
    
    // Network is unreachable
    static func isUnreachable(completed: @escaping (NetWorkStatusManager) -> Void) {
        if (NetWorkStatusManager.shared.reachability).connection == .unavailable { completed(NetWorkStatusManager.shared)
        }
    }
    
    // Network is reachable via WWAN/Cellular
    static func isReachableViaWWAN(completed: @escaping (NetWorkStatusManager) -> Void) {
        if (NetWorkStatusManager.shared.reachability).connection == .cellular { completed(NetWorkStatusManager.shared)
        }
    }
    
    // Network is reachable via WiFi
    static func isReachableViaWiFi(completed: @escaping (NetWorkStatusManager) -> Void) {
        if (NetWorkStatusManager.shared.reachability).connection == .wifi { completed(NetWorkStatusManager.shared)
        }
    }
}


extension NetWorkStatusManager{
    
    static let connectWork:BehaviorRelay<Bool> = BehaviorRelay<Bool>(value:true)
}
