//
//  Component.swift
//  Panda
//
//  Copyright (c) 2018 Javier Zhang (https://wordlessj.github.io/)
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

import Foundation

private var renderStateKey: UInt8 = 0
private var propsKey: UInt8 = 0
private var stateKey: UInt8 = 0
private var prevPropsKey: UInt8 = 0
private var prevStateKey: UInt8 = 0
private var oldElementKey: UInt8 = 0

enum RenderState {
    case normal, dirty, rendering
}

public protocol Renderable {
    func doRender() -> Bool
    func doDidRender()
}

public protocol SetRenderable: AnyObject, AssociatedObject {}

extension SetRenderable {
    var renderState: RenderState {
        get { return associatedObject(key: &renderStateKey) ?? .normal }
        set { setAssociatedObject(key: &renderStateKey, value: newValue) }
    }

    public func setNeedsRender() {
        guard renderState == .normal else { return }
        renderState = .dirty
        ComponentUpdater.shared.add(self)
    }

    public func forceRender() {
        guard renderState != .rendering else { return }
        renderState = .dirty
        renderIfNeeded()
    }

    public func renderIfNeeded() {
        guard let component = self as? Renderable, renderState == .dirty else { return }
        LayoutManager.shared.beginLayout()
        renderState = .rendering
        let shouldRender = component.doRender()
        renderState = .normal

        if shouldRender {
            LayoutManager.shared.addRendered(component)
        }

        LayoutManager.shared.endLayout()
    }
}

public typealias PropsProtocol = Initable
public typealias StateProtocol = PropsProtocol

public protocol Component: Renderable, SetRenderable {
    associatedtype Props: PropsProtocol
    associatedtype State: StateProtocol

    var renderObject: Any { get }

    func render() -> ElementProtocol
    func shouldRender(prevProps: Props, prevState: State) -> Bool
    func willRender(prevProps: Props, prevState: State)
    func didRender(prevProps: Props, prevState: State)
}

extension Component {
    public var props: Props {
        get { return associatedObject(key: &propsKey) ?? Props() }
        set {
            if prevProps == nil {
                prevProps = props
            }

            setAssociatedObject(key: &propsKey, value: newValue)
            setNeedsRender()
        }
    }

    public var state: State {
        get { return associatedObject(key: &stateKey) ?? State() }
        set {
            if prevState == nil {
                prevState = state
            }

            setAssociatedObject(key: &stateKey, value: newValue)
            setNeedsRender()
        }
    }

    private var prevProps: Props? {
        get { return associatedObject(key: &prevPropsKey) }
        set { setAssociatedObject(key: &prevPropsKey, value: newValue) }
    }

    private var prevState: State? {
        get { return associatedObject(key: &prevStateKey) }
        set { setAssociatedObject(key: &prevStateKey, value: newValue) }
    }

    private var oldElement: OldElement? {
        get { return associatedObject(key: &oldElementKey) }
        set { setAssociatedObject(key: &oldElementKey, value: newValue) }
    }

    private var somePrevProps: Props { return prevProps ?? props }
    private var somePrevState: State { return prevState ?? state }

    public var renderObject: Any { return self }

    public func doRender() -> Bool {
        let p = somePrevProps
        let s = somePrevState
        let should = shouldRender(prevProps: p, prevState: s)

        if should {
            willRender(prevProps: p, prevState: s)
            let element = render()
            element.apply(to: renderObject, old: oldElement)
            oldElement = element.toOld()
        }

        return should
    }

    public func doDidRender() {
        let p = somePrevProps
        let s = somePrevState
        prevProps = nil
        prevState = nil
        didRender(prevProps: p, prevState: s)
    }

    public func shouldRender(prevProps: Props, prevState: State) -> Bool { return true }
    public func willRender(prevProps: Props, prevState: State) {}
    public func didRender(prevProps: Props, prevState: State) {}
}

extension Component where Self: UICollectionViewCell {
    public var renderObject: Any { return contentView }
}

extension Component where Self: UITableViewCell {
    public var renderObject: Any { return contentView }
}

extension Component where Self: UITableViewHeaderFooterView {
    public var renderObject: Any { return contentView }
}

extension Component where Self: UIViewController {
    public var renderObject: Any { return view }
}
