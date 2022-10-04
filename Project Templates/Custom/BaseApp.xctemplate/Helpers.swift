//
//  Helpers.swift
//  NewTalk
//
//  Created by hsu tzu Hsuan on 2020/11/17.
//

import Foundation

import UIKit

enum Log {
    static func assertionFailure(
        _ message: @autoclosure () -> String,
        file: StaticString = #file,
        line: UInt = #line)
    {
        Swift.assertionFailure("[wanWatch] \(message())", file: file, line: line)
    }
    
    static func fatalError(
        _ message: @autoclosure () -> String,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Never
    {
        Swift.fatalError("[wanWatch] \(message())", file: file, line: line)
    }
    
    static func precondition(
        _ condition: @autoclosure () -> Bool,
        _ message: @autoclosure () -> String,
        file: StaticString = #file,
        line: UInt = #line
    )
    {
        Swift.precondition(condition(), "[wanWatch] \(message())", file: file, line: line)
    }
    
    static func print(_ items: Any...) {
        let s = items.reduce("") { result, next in
            return result + String(describing: next)
        }
        Swift.print("[wanWatch] \(s)")
    }
}

public let kScreenWidth: CGFloat = UIScreen.main.bounds.width

public let kScreenHeight: CGFloat = UIScreen.main.bounds.height

public let kScreenBounds: CGRect = UIScreen.main.bounds

public var kStatusBarHeight: CGFloat {
    
    if #available(iOS 13.0, *) {
        return UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? .zero
    }
    else {
        return UIApplication.shared.statusBarFrame.height
    }
}

public var kSafeAreaInsets: UIEdgeInsets {
    
    guard let view = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else {
        return .init()
    }
    
    if #available(iOS 11.0, *) {
        return view.safeAreaInsets
    } else {
        return .init()
    }
}

public var kTopSafeArea: CGFloat {
    max(kSafeAreaInsets.top, kSafeAreaInsets.left)
}

public var kBottomSafeArea: CGFloat {
    max(kSafeAreaInsets.bottom, kSafeAreaInsets.right)
}

public var kLeftSafeArea: CGFloat {
    min(kSafeAreaInsets.top, kSafeAreaInsets.left)
}

public var kRightSafeArea: CGFloat {
    min(kSafeAreaInsets.bottom, kSafeAreaInsets.right)
}

public var kTabBarHeight: CGFloat {
    kStatusBarHeight > 20 ? 49 : 32
}

extension UIView {
    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leadingAnchor
        } else {
            return leadingAnchor
        }
    }
    
    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.trailingAnchor
        } else {
            return trailingAnchor
        }
    }
}

extension UIViewController {
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return view.safeAreaLayoutGuide.topAnchor
        } else {
            return topLayoutGuide.bottomAnchor
        }
    }

    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return view.safeAreaLayoutGuide.bottomAnchor
        } else {
            return bottomLayoutGuide.topAnchor
        }
    }
    
    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return view.safeAreaLayoutGuide.leadingAnchor
        } else {
            return view.leadingAnchor
        }
    }
    
    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return view.safeAreaLayoutGuide.trailingAnchor
        } else {
            return view.trailingAnchor
        }
    }

    var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets
        } else {
            return .zero
        }
    }
}

extension Int {
    var kRealValue: CGFloat { CGFloat(self) * (kScreenWidth / 375.0) }
    
//    var kRealHeightValue: CGFloat { self * (kScreenHeight / 834.0) }
}

