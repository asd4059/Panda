//
//  Font.swift
//  Panda
//
//  Copyright (c) 2017 Javier Zhang (https://wordlessj.github.io/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

public protocol FontContainer: class {
    var containedFont: UIFont? { get set }
}

extension Element where Object: FontContainer, Object: UIView {
    @discardableResult
    public func font(_ value: UIFont?) -> Self {
        return addAttributes(key: "font", value: value) {
            $0.containedFont = value
            $0.invalidateLayout()
        }
    }

    @discardableResult
    public func font(style: UIFontTextStyle) -> Self {
        return font(.preferredFont(forTextStyle: style))
    }

    @available(iOS 10.0, *)
    @discardableResult
    public func font(style: UIFontTextStyle, compatibleWith traitCollection: UITraitCollection?) -> Self {
        return font(.preferredFont(forTextStyle: style, compatibleWith: traitCollection))
    }

    @discardableResult
    public func font(size: CGFloat) -> Self {
        return font(.systemFont(ofSize: size))
    }

    @discardableResult
    public func font(size: CGFloat, weight: UIFont.Weight) -> Self {
        return font(.systemFont(ofSize: size, weight: weight))
    }

    @discardableResult
    public func font(boldSize size: CGFloat) -> Self {
        return font(.boldSystemFont(ofSize: size))
    }

    @discardableResult
    public func font(italicSize size: CGFloat) -> Self {
        return font(.italicSystemFont(ofSize: size))
    }

    @discardableResult
    public func font(monospacedDigitSize size: CGFloat, weight: UIFont.Weight) -> Self {
        return font(.monospacedDigitSystemFont(ofSize: size, weight: weight))
    }
}

extension UIButton: FontContainer {
    public var containedFont: UIFont? {
        get { return titleLabel?.font }
        set { titleLabel?.font = newValue }
    }
}

extension UILabel: FontContainer {
    public var containedFont: UIFont? {
        get { return font }
        set { font = newValue }
    }
}

extension UITextField: FontContainer {
    public var containedFont: UIFont? {
        get { return font }
        set { font = newValue }
    }
}

extension UITextView: FontContainer {
    public var containedFont: UIFont? {
        get { return font }
        set { font = newValue }
    }
}
