//
//  NSMutableParagraphStyle.swift
//  Panda
//
//  Baby of PandaMom. DO NOT TOUCH.
//

import UIKit

extension PandaChain where Object: NSMutableParagraphStyle {
    @discardableResult
    public func lineSpacing(_ value: CGFloat) -> PandaChain {
        object.lineSpacing = value
        return self
    }

    @discardableResult
    public func paragraphSpacing(_ value: CGFloat) -> PandaChain {
        object.paragraphSpacing = value
        return self
    }

    /// `alignment`
    @discardableResult
    public func align(_ value: NSTextAlignment) -> PandaChain {
        object.alignment = value
        return self
    }

    @available(*, deprecated, renamed: "align()")
    @discardableResult
    public func alignment(_ value: NSTextAlignment) -> PandaChain {
        object.alignment = value
        return self
    }

    @discardableResult
    public func firstLineHeadIndent(_ value: CGFloat) -> PandaChain {
        object.firstLineHeadIndent = value
        return self
    }

    @discardableResult
    public func headIndent(_ value: CGFloat) -> PandaChain {
        object.headIndent = value
        return self
    }

    @discardableResult
    public func tailIndent(_ value: CGFloat) -> PandaChain {
        object.tailIndent = value
        return self
    }

    /// `lineBreakMode`
    @discardableResult
    public func lineBreak(_ value: NSLineBreakMode) -> PandaChain {
        object.lineBreakMode = value
        return self
    }

    @available(*, deprecated, renamed: "lineBreak()")
    @discardableResult
    public func lineBreakMode(_ value: NSLineBreakMode) -> PandaChain {
        object.lineBreakMode = value
        return self
    }

    /// `minimumLineHeight`
    @discardableResult
    public func minLineHeight(_ value: CGFloat) -> PandaChain {
        object.minimumLineHeight = value
        return self
    }

    @available(*, deprecated, renamed: "minLineHeight()")
    @discardableResult
    public func minimumLineHeight(_ value: CGFloat) -> PandaChain {
        object.minimumLineHeight = value
        return self
    }

    /// `maximumLineHeight`
    @discardableResult
    public func maxLineHeight(_ value: CGFloat) -> PandaChain {
        object.maximumLineHeight = value
        return self
    }

    @available(*, deprecated, renamed: "maxLineHeight()")
    @discardableResult
    public func maximumLineHeight(_ value: CGFloat) -> PandaChain {
        object.maximumLineHeight = value
        return self
    }

    @discardableResult
    public func baseWritingDirection(_ value: NSWritingDirection) -> PandaChain {
        object.baseWritingDirection = value
        return self
    }

    @discardableResult
    public func lineHeightMultiple(_ value: CGFloat) -> PandaChain {
        object.lineHeightMultiple = value
        return self
    }

    @discardableResult
    public func paragraphSpacingBefore(_ value: CGFloat) -> PandaChain {
        object.paragraphSpacingBefore = value
        return self
    }

    @discardableResult
    public func hyphenationFactor(_ value: Float) -> PandaChain {
        object.hyphenationFactor = value
        return self
    }

    @discardableResult
    public func tabStops(_ value: [NSTextTab]?) -> PandaChain {
        object.tabStops = value
        return self
    }

    @discardableResult
    public func defaultTabInterval(_ value: CGFloat) -> PandaChain {
        object.defaultTabInterval = value
        return self
    }

    /// `allowsDefaultTighteningForTruncation`
    @available(iOS 9.0, *)
    @discardableResult
    public func tightenable(_ value: Bool) -> PandaChain {
        object.allowsDefaultTighteningForTruncation = value
        return self
    }

    @available(*, deprecated, renamed: "tightenable()")
    @available(iOS 9.0, *)
    @discardableResult
    public func allowsDefaultTighteningForTruncation(_ value: Bool) -> PandaChain {
        object.allowsDefaultTighteningForTruncation = value
        return self
    }

    @available(iOS 9.0, *)
    @discardableResult
    public func paragraphStyle(_ obj: NSParagraphStyle) -> PandaChain {
        object.setParagraphStyle(obj)
        return self
    }
}
