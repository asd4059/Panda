//
//  UIRefreshControl.swift
//  Panda
//
//  Baby of PandaMom. DO NOT TOUCH.
//

import UIKit

public protocol UIRefreshControlConvertible {}

extension UIRefreshControl: UIRefreshControlConvertible {}
extension PandaChain: UIRefreshControlConvertible {}

extension PandaChain where Object: UIRefreshControl {
    /// `tintColor`
    @discardableResult
    public func tint(_ value: UIColor?) -> PandaChain {
        object.tintColor = value
        return self
    }

    @available(*, deprecated, renamed: "tint()")
    @discardableResult
    public func tintColor(_ value: UIColor?) -> PandaChain {
        object.tintColor = value
        return self
    }

    @discardableResult
    public func attributedTitle(_ value: NSAttributedString?) -> PandaChain {
        object.attributedTitle = value
        return self
    }
}
